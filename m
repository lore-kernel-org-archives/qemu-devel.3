Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1364FD88F4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0B42-0006Zr-NY; Wed, 11 Mar 2026 00:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3x-0006UX-0M
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3v-00032q-8m
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3FMr7248220
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qEoZ2yhQSd0N8+lGnutu6ZeOmCG/eAyiRHcsiOA2+sA=; b=YDmIZlwUykgL6JAA
 v7NFIuebj3DQX0C3g831jNS9hX+uRGSC+S5+Y2iaLYSpUGT6Qn3q8WfdJI5AcvvE
 iBT4+n54uGiQ22IOdM/wHAytrIEkfrfWN7cbgCeHEeRT7XyCZGQ1BoZMbTpMxXwl
 bgR8ZaSlbHrz/F61Q+5HFZ6IALvDfOl+zASqRl4Ps3HTanXqRgE7TzOFbzIFcRq/
 JWTyWjaVk02m9kkZrktMZDib6QkpfqZlbwdMe4pjgRX0o+Fsgb8kJY4rd0fNV5MU
 vs6KvCpvgh3XdoTFlal3jllFD8hX5nq7qNm6DHphkaORSmZy+mPb++65whwDxo5D
 ReISow==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv11tyg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:35 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7d73fe3f986so29445466a34.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202834; x=1773807634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEoZ2yhQSd0N8+lGnutu6ZeOmCG/eAyiRHcsiOA2+sA=;
 b=IgF1+2AkBQQfC9goadWjV961DMn0c0/agUtNI9mYBFtj6LEtBni2CViGWWIlVZj2Pl
 gZ9PwuaFzNYpimzdmPv+uFYEBJBJut5AI9V3kw2EWzQgn7CrRWbed+VhYKf6MHYp3NQ1
 pWeBDPpXlicGBTu65QpTG2W7IwejQ/0Ew5PwRRRyaH7zIezL1EeBevJENiQsLYD4gT2Z
 Ono4uYa7WTMXdETGpffUiVWaxBmyaj7vcALVsoe6LiZX3LbfUwZKYNXgepjXR6o7aMuT
 3001uH8LPMEb8785jC/jhpSNF7GSAhjtqIxcEmp1tlbwAnygO0J8U1NF9lmU9GcUmBja
 yK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202834; x=1773807634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qEoZ2yhQSd0N8+lGnutu6ZeOmCG/eAyiRHcsiOA2+sA=;
 b=D6ast1/4c68hodAlpUIJS4JEAIRpRCfkPSxtfZr7M3qSKo9YsLf1OitR/Rpt+8XMAa
 Dp9WNIy9gzFALqyUE6u/Z2gJLAYaIbMhfxEK3CJVzN4iAnQBgE0JwSOJF2MCEKlznfvq
 cVG5PpicCdYP7UNR88046/VIHPdAepPrDq91FTlD+aIMLowKN+IJkbEtldR/dlBb+jA2
 SjXxj5aEo1GRowhJdlnPPt/og61XlTXO1f5/VeaXZdP1px/a4ZEL3FYtTkJUyJhv0KPc
 kM7f33EoKX7lLQKhncAPrjafNkW9OFnFGRI1KBDdu6dNJQ9ejl8c3s0LZtR31wdJcgHH
 BklQ==
X-Gm-Message-State: AOJu0YxPqib9vgzylhk8luJtDl4Z+NuSwT84I4Tfb5fQjJRqHtTVaouS
 H5Kf/zUWsR2gTCKNcOq8Ll6EkeeM0/XKXz9LbDqssdMkigpccZT4Y8tXmiv8/NdxzDDRV/aIAC9
 7ef2fxgAXwVWTjfp3i9NfuM/s3xwtamFGGZmLOA87qXmZrpywZsNjEfPXOl0vQqYDDA==
X-Gm-Gg: ATEYQzw5/c6DEG66RRO8ePVhrt2ro+gH52PTmTJnaXcygPLw+qy6D2786CsvzSsklh9
 TPYQedyhkQlTuwzxb34ix6RdLr4EshjDY9QCtfeKOqkFy4aZ1+vy/o8v0mP5QCad4ywsV3ru597
 vDyCSQcDBvxsTKHOLgxYCAL3hAB0EykCECnmQpuF2i0y0v2nVt6ZoOqrMXzJwiw+oo+w0tIy/Ox
 Ym9pUsYN5CZ47aAbVHc6exApaWQqyjyrKNTKF3mmSBluWOTHEh7eLfhDjC7639LDhAz46SXCZxS
 qx6TW1oM59SzOYK/kbV82ORDt9k6GVzW8q5sMSVXv89AKT+wqgsM3WkS6r3w/45QX9D62bJENit
 cWMfvR3q2xw9kNJeaogr6UfRQrHRnl197V59QVn54oyoTLNUE9cIXWZ96ifXWDgLKkoUaCA==
X-Received: by 2002:a05:6830:4423:b0:7cf:d819:a2d2 with SMTP id
 46e09a7af769-7d76a8f285bmr1006362a34.31.1773202834477; 
 Tue, 10 Mar 2026 21:20:34 -0700 (PDT)
X-Received: by 2002:a05:6830:4423:b0:7cf:d819:a2d2 with SMTP id
 46e09a7af769-7d76a8f285bmr1006350a34.31.1773202834098; 
 Tue, 10 Mar 2026 21:20:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aeccd73sm892003a34.27.2026.03.10.21.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:20:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 9/9] tests/qtest: Add hexagon boot-serial-test
Date: Tue, 10 Mar 2026 21:20:19 -0700
Message-Id: <20260311042019.1085030-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMyBTYWx0ZWRfX2puVDMH/zKhO
 GC7epc2eN7Q8mkeWzoGrHGlraQv0LDuKTn2LZq8EBE9XMt4T120BBRUmMpn8hx51KNqpi/JXXo5
 5D/0XQNFRe161HgyiYnc1OaXO7norv8Eu/zfqbjEYQ+jHM77P99QMeWyBwbllWc9KfnjB18O+tc
 f8Af2BAzEfqs6/Io6+18mszbiMK13kdOwFu4xjFWVbxRT3FLrA5Rv/b312HOYiGhw2MQR9+220i
 FchRubxmNKZlAu5Z79fPBpJ/FWrMXG5r3NthE+56ykvQnujPCAqZa+wFjlkXxN8dkQaiBZdzWfL
 FpIXo/rX9vZ8942HWrwPPuetxB8+yxfTDEF08dsxqDBK+lu7+U3YD56GZYN1esaCqaVeAB7TlY5
 ZUE3w7fy8MZh71tQIibgpA3q2Cutl+cMTEIBQ7pWlwTeqHNcjFTbaDco2VFeYQgVn/hOxgB42Z2
 M8IoxkdSB6BRHcj0GVA==
X-Proofpoint-GUID: wh_XVNYrjQPu-tR6_Tch1ZuJB5xwt8zM
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b0ed93 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=mx_w8yxdHMTqIFmIFlQA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: wh_XVNYrjQPu-tR6_Tch1ZuJB5xwt8zM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QWRkIGJvb3Qtc2VyaWFsLXRlc3Qgc3VwcG9ydCBmb3IgSGV4YWdvbiBhcmNoaXRlY3R1cmUgdXNp
bmcgdGhlIHZpcnQKbWFjaGluZS4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMg
fCA4ICsrKysrKysrCiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAgfCAyICsrCiAyIGZp
bGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9i
b290LXNlcmlhbC10ZXN0LmMgYi90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMKaW5kZXgg
YmNkMGE5YzUwZTcuLjM3ZmVlN2E5MWM0IDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9ib290LXNl
cmlhbC10ZXN0LmMKKysrIGIvdGVzdHMvcXRlc3QvYm9vdC1zZXJpYWwtdGVzdC5jCkBAIC0xNDIs
NiArMTQyLDEzIEBAIHN0YXRpYyBjb25zdCB1aW50OF90IGtlcm5lbF9zdG0zMnZsZGlzY292ZXJ5
W10gPSB7CiAgICAgMHgwNCwgMHgzOCwgMHgwMSwgMHg0MCAgICAgICAgICAgICAgICAgIC8qIDB4
NDAwMTM4MDQgPSBVU0FSVDEgVFhEICovCiB9OwogCitzdGF0aWMgY29uc3QgdWludDhfdCBiaW9z
X2hleGFnb25bXSA9IHsKKyAgICAweDAwLCAweDQwLCAweDAwLCAweDAxLCAgICAgICAgICAgICAg
ICAgLyogaW1tZXh0KCMweDEwMDAwMDAwKSAqLworICAgIDB4MDAsIDB4YzAsIDB4MDAsIDB4Nzgs
ICAgICAgICAgICAgICAgICAvKiByMCA9ICMjMHgxMDAwMDAwMCAqLworICAgIDB4NTQsIDB4YzAs
IDB4MDAsIDB4M2MsICAgICAgICAgICAgICAgICAvKiBtZW1iKHIwKyMwKSA9ICMweDU0IFdyaXRl
ICdUJyAqLworICAgIDB4ZjgsIDB4ZmYsIDB4ZmYsIDB4NTkgICAgICAgICAgICAgICAgICAvKiBq
dW1wIDB4MCA7IExvb3AgYmFjayB0byBzdGFydCAqLworfTsKKwogdHlwZWRlZiBzdHJ1Y3QgdGVz
dGRlZiB7CiAgICAgY29uc3QgY2hhciAqYXJjaDsgICAgICAgLyogVGFyZ2V0IGFyY2hpdGVjdHVy
ZSAqLwogICAgIGNvbnN0IGNoYXIgKm1hY2hpbmU7ICAgIC8qIE5hbWUgb2YgdGhlIG1hY2hpbmUg
Ki8KQEAgLTE5NCw2ICsyMDEsNyBAQCBzdGF0aWMgY29uc3QgdGVzdGRlZl90IHRlc3RzW10gPSB7
CiAgICAgeyAiYXJtIiwgIm1pY3JvYml0IiwgIiIsICJUIiwgc2l6ZW9mKGtlcm5lbF9ucmY1MSks
IGtlcm5lbF9ucmY1MSB9LAogICAgIHsgImFybSIsICJzdG0zMnZsZGlzY292ZXJ5IiwgIiIsICJU
IiwKICAgICAgIHNpemVvZihrZXJuZWxfc3RtMzJ2bGRpc2NvdmVyeSksIGtlcm5lbF9zdG0zMnZs
ZGlzY292ZXJ5IH0sCisgICAgeyAiaGV4YWdvbiIsICJ2aXJ0IiwgIiIsICJUVCIsIHNpemVvZihi
aW9zX2hleGFnb24pLCBOVUxMLCBiaW9zX2hleGFnb24gfSwKIAogICAgIHsgTlVMTCB9CiB9Owpk
aWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgYi90ZXN0cy9xdGVzdC9tZXNvbi5i
dWlsZAppbmRleCBiYTlmNTlkMmY4Zi4uZDgzY2IwNWNjOGMgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0
ZXN0L21lc29uLmJ1aWxkCisrKyBiL3Rlc3RzL3F0ZXN0L21lc29uLmJ1aWxkCkBAIC0yOTAsNiAr
MjkwLDggQEAgcXRlc3RzX3Jpc2N2NjQgPSBbJ3Jpc2N2LWNzci10ZXN0J10gKyBcCiAgICBjb25m
aWdfYWxsX2RldmljZXMuaGFzX2tleSgnQ09ORklHX1JJU0NWX0lPTU1VJykgPwogICAgWydpb21t
dS1yaXNjdi10ZXN0J10gOiBbXSkKIAorcXRlc3RzX2hleGFnb24gPSBbJ2Jvb3Qtc2VyaWFsLXRl
c3QnXQorCiBxb3NfdGVzdF9zcyA9IHNzLnNvdXJjZV9zZXQoKQogcW9zX3Rlc3Rfc3MuYWRkKAog
ICAnYWM5Ny10ZXN0LmMnLAotLSAKMi4zNC4xCgo=

