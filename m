Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73E4C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vAP-0006eJ-OO; Thu, 24 Sep 2026 21:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9vAK-0006QG-KE
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9vAI-0006Bs-Qq
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:56 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kpRw155477
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lclfi+ZCjr/7m4gZFFfrOksvETqxs1O42a0oc4pPqFE=; b=lTdc+i1jyH59JmAO
 k6JeXGVXN2plbsaVgUiPiJ6Y96IpK/UgPlt5oOWSqdS8LTux3WlQymQfJr3iK12i
 Zmf3YeDfJpVOd7veVYPmtFww2B8HrAyBrQ0L41iG58iVbQX0/3/o/jOa79JX/0Os
 nTcKPdchYeDGiZnZAR18cBR5o1aNpP5FcVjYCfyOJH8fhQNT2ObOAQcuMupKIJek
 JdCHM3kOYJZn+wJ0lifltMyAaQtCDO5nF5fMhUAnZ9LYaeo0rxaaV/qRkSQKswUV
 fkD2qyenI08E1RJyVjDGxkXcfZylG4Z9wYD4iS1VRGRb0FIXKOkrE/OWHHliAn2Y
 CRN6Xg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjkdbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341b0999491so197131eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301343; x=1790906143; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lclfi+ZCjr/7m4gZFFfrOksvETqxs1O42a0oc4pPqFE=;
 b=io2QGHj5pHhmLrL1EjA0xTRuBebVp80so40KvpLW45mkrBTRH9rcgILaGj1inAsUbe
 BRM5GruLcZVEaA7+DlaUbSWOmCmD1DfWsTJMYoPPsVq3Bq7yzABTi7zC9jlSm1bqMSCZ
 V11pR/IBOUAj11M+xSbvo5f/HH+5jbeuuFC75oYuVkXe+tay0ANJNrf4WgJNN3LTHaMa
 4FLiS+ivV4kEQb7tALlHUwLW2OEPv+vIM6rDmpKoonwhwjME831bfOXvicj34ecV3Gvu
 thlStdpxB2jFk5JzPR+9jvSuLSibPNaGgxmWnYQr2Ax+nWCfqgby8JLm1miGtMZwXglN
 Nfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301343; x=1790906143;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lclfi+ZCjr/7m4gZFFfrOksvETqxs1O42a0oc4pPqFE=;
 b=O7njz4dbVf+f8vnXo6H1+d+vX9Feh4EHEkZGOa45GDpgn0nmN9c+zb1+n/eAdYGYer
 48HLUJtPW+WZ8LM5yHWTx+76hGbdVKJhR0WZpuK+LykrgJGrsMUPSTr/YPML5HkceyFT
 CJRHgn01Cf88VlYQGaAQQ2NRylvryrABxkZl0rhoQxnuRv9F5itGx7+hZifTOkoduvBh
 fKK+RoKph1kquxx3cJw5s8rOc43Iym1gYDDHpMImjZo2KLtYzudC4zAqGfk0yC9KKMJJ
 ahFwlDovXU9+rbMpaxN10luw89TepVGSS6M/PRKx3+aWIZnlWS7Kdy/q0iWISPq/Q7d2
 oXbA==
X-Gm-Message-State: AFuF++nS0I12q+aDqP4O9HPmAbjcRWD13em64Qx7qcT+YV16PSfngiX8
 u7j4xjeqHd5+W10AlcGZArQxp9ZWR5306ngmWf1AoJMTv5qQE6W4F4dR2yTkWb1+bvvBLE+c0WC
 pQHnN9NNRlD2djqukfBMbYXi++FUAVnMissbbJVHBfUQiYIBT98HTSSdamBAbao48XA==
X-Gm-Gg: AYBFou1JqBC7XRucUQ37W5R+ntl89R+nY8i9onGc9W0ffoAiJkxG5pip3m5Tt/eUwia
 Kx53X+Sz4919pyZP9yn2xXiEjQc7mcOwojhbU6+hfNRuIoHYjRfWuPV7R6vjprGqo3HzXj5JQvf
 FmoohMy/sWQD3i180jwvnu+CHiy/hLSDwv/L51fOUnbBerB+nvcQEiHxQ/H+k1iCDroSmEAIt1Q
 TCad72T1zsRrKCC/73DKN5gvUn0RuYrogh8ZtZEu8aggoLoEUXtA7UG5jyuNFJxOmjwIuCW4lE7
 6BydmS0s+LWmkh1yBbGPCc786yS+pb/ixEbVx8jGqFg7uEwu9QMsOb5lqhhZHZ3lE7/dyKPm2Cc
 O5s7MlvhFC3vFyDOy5pYybilXkB+WLkgAiLMg3LROpH0HQqk=
X-Received: by 2002:a05:7300:ce07:b0:328:7033:9b8c with SMTP id
 5a478bee46e88-3400439f7a9mr3239688eec.6.1790301342526; 
 Thu, 24 Sep 2026 18:55:42 -0700 (PDT)
X-Received: by 2002:a05:7300:ce07:b0:328:7033:9b8c with SMTP id
 5a478bee46e88-3400439f7a9mr3239671eec.6.1790301341859; 
 Thu, 24 Sep 2026 18:55:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 36/40] target/hexagon: fix HVX scatter/gather region-length
 check
Date: Thu, 24 Sep 2026 18:54:25 -0700
Message-Id: <20260925015429.2579174-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: GLoTEiyuuIYZcjRBv0AOYHKI8S-Y93_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX0vWuqIM66Bk/
 ahZDw1u6iqwpXO1D/ylJ+kzGypDqj95DlCXKura0guYdIQ4IpZUjmb9h+k0KNUFpgX2S9Yjhi0v
 viU2HQuI/6eWgyHbB/D1o+6I3cnvBuTSJE8og5zkdbg9MXDZ+Y0LkK8OsiP+vmygsX4yEtMPXbn
 dhPIzFKSqQiJmuqwjsSGK5QxpkHX8p9ix9oOl1AOifbc7e2ztuQcC/S7HCZfqob6838rjSGYoaG
 JbCM66gkcEA85Q2sz2+ZdFpK2uuGE+D9tZaJxEYHBnuiVK+pFuq/7SrBuT0geHQRlw4XdoREU3m
 T+Xjqkd/PItKY9ohJUO2kmnHzd5xM8vsPU4hACiWn9uu7ly7paFEIUCUvlAtYMS9RDWrdCvG0pm
 DcRZLNAoUMZ8YUxzQDBrUjHM3egHb6nqy1dfd6egNxSdGssTEMfF+W2ShMgGriczy9SogdZfmts
 J0qWvyMdiOlllEtAgNA==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab5d49f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=dpjYNSh0uHncNrtL9ygA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: GLoTEiyuuIYZcjRBv0AOYHKI8S-Y93_5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX8mmKn/QQx2Yp
 /z2W5XW7FkI6lDOZ83+NxOTo8VA0Ijmwduf+zOzPVky/1TInCPqiZmPiBxfVZges8IQ1aNITQ4i
 /NVLof6ZdTU+VhP+t1ESLU0cNe3cw20=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250007
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGhlIHJlZ2lvbi1sZW5ndGggYm91bmRzIGNoZWNrIGNvbXBhcmVkIChFQSArIGkwKSA8PSAoRUEg
KyBMRU4pLAp3aGljaCByZWR1Y2VzIHRvIGkwIDw9IExFTiBhbmQgbmV2ZXIgYWN0dWFsbHkgZGVw
ZW5kcyBvbiB0aGUgcmVnaW9uCmJhc2UuIFRoaXMgbGV0IHZnYXRoZXIvdnNjYXR0ZXIga2VlcCBl
bGVtZW50cyB3aG9zZSBvZmZzZXQgd2FzCmJleW9uZCB0aGUgZGVjbGFyZWQgcmVnaW9uIGluc3Rl
YWQgb2YgZHJvcHBpbmcgdGhlbS4gQ29tcGFyZSB0aGUKb2Zmc2V0IHRvIHRoZSByZWdpb24gbGVu
Z3RoIGRpcmVjdGx5IGluc3RlYWQuCgpPbmx5IGxvYWQgYnl0ZXMgZm9yIGdhdGhlciBsYW5lcyB0
aGF0IGFyZSBrZXB0LiBBIGRyb3BwZWQgb3IKcHJlZGljYXRlLWZhbHNlIGxhbmUgbXVzdCBub3Qg
YWNjZXNzIG1lbW9yeSBhbmQgcmFpc2UgYW4gZXhjZXB0aW9uLgoKUmV2aWV3ZWQtYnk6IE1hdGhl
dXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxtYXRoZXVzLmJlcm5hcmRpbm9Ab3NzLnF1YWxjb21tLmNv
bT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIHRhcmdldC9oZXhhZ29uL21tdmVjL21hY3Jvcy5oIHwgMzEgKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDE0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21tdmVjL21hY3Jvcy5oIGIv
dGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmgKaW5kZXggNWUzNDZiNzI5NmYuLmY4NWQ5OTcz
NWQyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tbXZlYy9tYWNyb3MuaAorKysgYi90YXJn
ZXQvaGV4YWdvbi9tbXZlYy9tYWNyb3MuaApAQCAtMTMwLDkgKzEzMCw5IEBACiAgICAgZG8geyBc
CiAgICAgICAgIGludCBsb2dfYnl0ZSA9IDA7IFwKICAgICAgICAgdGFyZ2V0X3Vsb25nIHZhID0g
RUE7IFwKLSAgICAgICAgdGFyZ2V0X3Vsb25nIHZhX2hpZ2ggPSBFQSArIExFTjsgXAorICAgICAg
ICBpbnQgaW5fcmVnaW9uID0gKE9GRlNFVCkgPD0gKExFTik7IFwKICAgICAgICAgZm9yIChpbnQg
aTAgPSAwOyBpMCA8IDQ7IGkwKyspIHsgXAotICAgICAgICAgICAgbG9nX2J5dGUgPSAodmEgKyBp
MCkgPD0gdmFfaGlnaDsgXAorICAgICAgICAgICAgbG9nX2J5dGUgPSBpbl9yZWdpb247IFwKICAg
ICAgICAgICAgIExPR19WVENNX0JZVEUodmEgKyBpMCwgbG9nX2J5dGUsIFwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGhleGFnb25fbW12ZWNfZ2V0X2J5dGUoJihJTkMpLCA0ICogSURYICsg
aTApLCBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgIDQgKiBJRFggKyBpMCk7IFwKQEAgLTE0
Miw5ICsxNDIsOSBAQAogICAgIGRvIHsgXAogICAgICAgICBpbnQgbG9nX2J5dGUgPSAwOyBcCiAg
ICAgICAgIHRhcmdldF91bG9uZyB2YSA9IEVBOyBcCi0gICAgICAgIHRhcmdldF91bG9uZyB2YV9o
aWdoID0gRUEgKyBMRU47IFwKKyAgICAgICAgaW50IGluX3JlZ2lvbiA9IChPRkZTRVQpIDw9IChM
RU4pOyBcCiAgICAgICAgIGZvciAoaW50IGkwID0gMDsgaTAgPCAyOyBpMCsrKSB7IFwKLSAgICAg
ICAgICAgIGxvZ19ieXRlID0gKHZhICsgaTApIDw9IHZhX2hpZ2g7IFwKKyAgICAgICAgICAgIGxv
Z19ieXRlID0gaW5fcmVnaW9uOyBcCiAgICAgICAgICAgICBMT0dfVlRDTV9CWVRFKHZhICsgaTAs
IGxvZ19ieXRlLCBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZXhhZ29uX21tdmVjX2dl
dF9ieXRlKCYoSU5DKSwgMiAqIElEWCArIGkwKSwgXAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAyICogSURYICsgaTApOyBcCkBAIC0xNTYsOSArMTU2LDkgQEAKICAgICBkbyB7IFwKICAgICAg
ICAgaW50IGxvZ19ieXRlID0gMDsgXAogICAgICAgICB0YXJnZXRfdWxvbmcgdmEgPSBFQTsgXAot
ICAgICAgICB0YXJnZXRfdWxvbmcgdmFfaGlnaCA9IEVBICsgTEVOOyBcCisgICAgICAgIGludCBp
bl9yZWdpb24gPSAoT0ZGU0VUKSA8PSAoTEVOKTsgXAogICAgICAgICBmb3IgKGludCBpMCA9IDA7
IGkwIDwgMjsgaTArKykgeyBcCi0gICAgICAgICAgICBsb2dfYnl0ZSA9ICh2YSArIGkwKSA8PSB2
YV9oaWdoOyBcCisgICAgICAgICAgICBsb2dfYnl0ZSA9IGluX3JlZ2lvbjsgXAogICAgICAgICAg
ICAgTE9HX1ZUQ01fQllURSh2YSArIGkwLCBsb2dfYnl0ZSwgXAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaGV4YWdvbl9tbXZlY19nZXRfYnl0ZSgmKElOQyksIDIgKiBJRFggKyBpMCksIFwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMiAqIElEWCArIGkwKTsgXApAQCAtMTcwLDE1ICsx
NzAsMTggQEAKICAgICBkbyB7IFwKICAgICAgICAgaW50IGkwOyBcCiAgICAgICAgIHRhcmdldF91
bG9uZyB2YSA9IEVBOyBcCi0gICAgICAgIHRhcmdldF91bG9uZyB2YV9oaWdoID0gRUEgKyBMRU47
IFwKICAgICAgICAgdWludHB0cl90IHJhID0gR0VUUEMoKTsgXAogICAgICAgICBpbnQgbG9nX2J5
dGUgPSAwOyBcCisgICAgICAgIGludCBpbl9yZWdpb24gPSAoT0ZGU0VUKSA8PSAoTEVOKTsgXAog
ICAgICAgICBmb3IgKGkwID0gMDsgaTAgPCBFTEVNRU5UX1NJWkU7IGkwKyspIHsgXAotICAgICAg
ICAgICAgbG9nX2J5dGUgPSAoKHZhICsgaTApIDw9IHZhX2hpZ2gpICYmIFFWQUw7IFwKLSAgICAg
ICAgICAgIHVpbnQ4X3QgQjsgXAotICAgICAgICAgICAgQiA9IGNwdV9sZHViX2RhdGFfcmEoZW52
LCBFQSArIGkwLCByYSk7IFwKLSAgICAgICAgICAgIGhleGFnb25fbW12ZWNfc2V0X2J5dGUoJmVu
di0+dG1wX1ZSZWdzWzBdLCBcCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVM
RU1FTlRfU0laRSAqIElEWCArIGkwLCBCKTsgXAorICAgICAgICAgICAgdWludDhfdCBCID0gMDsg
XAorICAgICAgICAgICAgXAorICAgICAgICAgICAgbG9nX2J5dGUgPSBpbl9yZWdpb24gJiYgUVZB
TDsgXAorICAgICAgICAgICAgaWYgKGxvZ19ieXRlKSB7IFwKKyAgICAgICAgICAgICAgICBCID0g
Y3B1X2xkdWJfZGF0YV9yYShlbnYsIHZhICsgaTAsIHJhKTsgXAorICAgICAgICAgICAgICAgIGhl
eGFnb25fbW12ZWNfc2V0X2J5dGUoJmVudi0+dG1wX1ZSZWdzWzBdLCBcCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBFTEVNRU5UX1NJWkUgKiBJRFggKyBpMCwgQik7IFwK
KyAgICAgICAgICAgIH0gXAogICAgICAgICAgICAgTE9HX1ZUQ01fQllURSh2YSArIGkwLCBsb2df
Ynl0ZSwgQiwgRUxFTUVOVF9TSVpFICogSURYICsgaTApOyBcCiAgICAgICAgIH0gXAogICAgIH0g
d2hpbGUgKDApCkBAIC0yNTAsMTAgKzI1MywxMCBAQAogICAgIGRvIHsgXAogICAgICAgICBpbnQg
aTA7IFwKICAgICAgICAgdGFyZ2V0X3Vsb25nIHZhID0gRUE7IFwKLSAgICAgICAgdGFyZ2V0X3Vs
b25nIHZhX2hpZ2ggPSBFQSArIExFTjsgXAogICAgICAgICBpbnQgbG9nX2J5dGUgPSAwOyBcCisg
ICAgICAgIGludCBpbl9yZWdpb24gPSAoT0ZGU0VUKSA8PSAoTEVOKTsgXAogICAgICAgICBmb3Ig
KGkwID0gMDsgaTAgPCBFTEVNX1NJWkU7IGkwKyspIHsgXAotICAgICAgICAgICAgbG9nX2J5dGUg
PSAoKHZhICsgaTApIDw9IHZhX2hpZ2gpICYmIFFWQUw7IFwKKyAgICAgICAgICAgIGxvZ19ieXRl
ID0gaW5fcmVnaW9uICYmIFFWQUw7IFwKICAgICAgICAgICAgIExPR19WVENNX0JZVEUodmEgKyBp
MCwgbG9nX2J5dGUsIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhleGFnb25fbW12ZWNf
Z2V0X2J5dGUoJihJTiksIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBFTEVNX1NJWkUgKiBJRFggKyBpMCksIFwKLS0gCjIuMzQuMQoK

