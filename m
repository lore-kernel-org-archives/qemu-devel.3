Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E53CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcktf-0006ve-3O; Thu, 25 Jun 2026 10:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wckta-0006uQ-P7
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktY-0008V6-JP
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9kE1e1948648
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=; b=Hv
 W13nef0RCmrR9bD4PJ7+yC9RExkPwqTfTN3Qk/p3vVW4CRw19fRvPhInNJ9Hh1vU
 zYY6mWmn5zEejX7YnoE9R/GhrLlUb3Qkc6vuYoltsqa8saMnSj694X0c6QmaL5v5
 W2jWCtvVRfckqeNhOoXID91l+7BDd5+VeqhMklHpb46smJvdOkcruu9amIJlnYm6
 0+im5LW2EOQL5k7Q2eHwwxfD4T6QG60UH9EjxG5x10hTxhLwitVnCoMuejw/0o9j
 Q7CzjTaATbUin682t5Qh8j3398O5GWCIC2RlWmraz0fteX4MuPjrnfBnUGhuxj6g
 MfwZaQ9hg6nFJZjhhIPg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ya8spm7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c17bc96afso4979702eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397041; x=1783001841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=;
 b=VRPMr+lKRVTP5D817br8+kZ9LYt7GyFYBQLza+BHk3DjF0ghqAlsdzqfn/QKVrSbrz
 haDPg+WxIBud6yoL43LkUTEsgT5y7IEu+PGe7aigjUr2EB9mAdiBzOFRFHU0ObLu9FeN
 dRuS1+xBqoXlrkMbF8gSMLCJOKWNjuxHRINw92kDQ3GYaHKtbRfEoevJgRgWA4yZlv88
 Uy9DCryvn7DIDl5kaE89mRJGZ0WxMiMUc1OCY5jsmskqosiQUrD9og1/xvbZ78wosoN+
 jxhrwFWaYKk13kJq1xksuhr4e28pBqflt3RMu9gxPPe71LVerZth07yGrxeB8q2CvTNk
 5sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397041; x=1783001841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=;
 b=Y+yy/5mh/ASoaHGPsVQaI8xh5giOWgv/R9hLc8RpyVNvYLMUSsSZR7Q/Dnd//Tcfge
 2/0ww8eiIBDbT7UOBEuzgzzXmAQBMyPExa4nTS2n8nRrEiSddxU6T0GdJ+oG2av1cxeN
 x3lcJTiUxs5MSSB+mDL0JdH9Uk0sEB6l9aWLJ+aRI26l+NLKi7O1grr/NLgiP/x922aU
 PgKImX3dG8mYYufIhfoQq8cbg11rKlS4CUX5+e/fZXCVMIl1fLXJ0k18Bv683pup+qOP
 IAXn7MbviAYqMLQFTpFLs+rHDEyJ+LOre/J9awMk0QwxRzoa4ELy/Plus/3SdwJmi2mQ
 heoQ==
X-Gm-Message-State: AOJu0YyZUXdwptcTQuPHI+UEJsRWQovydCJ8lonQDEM7wWzRs6iVywoo
 3AfutM3KqtOr02dreOT+1DiSo3uXFMBoHuIjFp+01Bxy32PRaLek4ygBFMmcQvnOppI4w0G2NN2
 J/JOP9h/ebe6Ai0wVjW0VgAs0A29IN5SPZKgiU2u/HDbLPmAz/ibH7ICToYfsr0qEsQ==
X-Gm-Gg: AfdE7cnmdntVfRebnbikmk6lYPjqZgI+1b3Kf+2+rItSoaGr5LA7ZDsRisNAyx8TJ1e
 7YxN2ikGDTbk5DqVk/1bXGO7QRBG2G26q64CP+TZPv8H01ELC9GsGvr2UR49VIp3+7Dsa9gCSud
 91+v0X4ZKNXi/JM8RCV8N8bqMI69xdzD5I5n3V3QnntGPN0hGFLlzBK8W5Pq6w0LMEQ0023rZyc
 +7QArKQ+TlK004aKreSdONPtP9MzCfZwIT5AsnBlC0SqSKAT0xLm873nZFUotAfkigkQqyBxtU+
 IspjBxn6bCyrluG5VzXJNjhxF4/qeP3df3c3ehMDklEjTt6lSOC0zOtP7820uZmG2R6Krtie0zC
 QfA/Sd7FjOuDNmvXtNuT9XUs7gHpCDMf9OQrxchoqy1kYZmlRD2aapQZwm4M=
X-Received: by 2002:a05:7301:2a08:b0:304:d82f:be10 with SMTP id
 5a478bee46e88-30c84bad8ddmr3658021eec.11.1782397040419; 
 Thu, 25 Jun 2026 07:17:20 -0700 (PDT)
X-Received: by 2002:a05:7301:2a08:b0:304:d82f:be10 with SMTP id
 5a478bee46e88-30c84bad8ddmr3657920eec.11.1782397039584; 
 Thu, 25 Jun 2026 07:17:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 21/76] target/hexagon: Add vmstate representation
Date: Thu, 25 Jun 2026 07:15:38 -0700
Message-Id: <20260625141633.449487-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX/e/Q0OaG3eZQ
 GoyKhUtw5nDesGxAdllH4NKtV6gpB05d0Of7r6yBxCUbmHt4iXiHOSU/fX6SeAL/0cv+Hw3rNRy
 YQPQ7Tntl3CckGSRLs6skuDBaCph3nw=
X-Proofpoint-GUID: LmxTD5AmEJxJnOqnIzHT9wJOp9XgvEbm
X-Proofpoint-ORIG-GUID: LmxTD5AmEJxJnOqnIzHT9wJOp9XgvEbm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX4Fl1+x40TTu7
 TOVz9RNt5obm0L4/z2ZBfuCu1947DU6IH12tNaO/gWmiBguaCeQMTzFf6glnxrXwzxSKxz6gjJO
 3splgZAEIq0SaiVijePtc2z982xsaKKXt2ZRaKwlWDNgwOsNmrrguAVR4ojrIfhphnKTB6o5zui
 H0IlXPcT4PycdeiNSWwlLrHWIcGHjFkeprjdNGMI0eQ+daMuEw10GnNzoOdDUsuPAuRhDM1rVTH
 wrRNTFWAiqLORnZX+Zzpn37s6Y4pkIqsqCAEG6mo1mhg7u3a9+R2bdmTcJ3dAIcozm3zME9HcW3
 rdzoZ9cRv90p7YNOjWIz3Izs76p5CAJsAoFcix5oQXuIImnx4zVMsMcxqRd0dirb4bIijH4NeNE
 CHpgUqhEAiaHf5KWWE7kyVldjElWSS1159q761V0MkQRRxt+VUcfJuMyCyHMta1KzFsbutYJI0+
 ysp7U+osNNyVGPl4spQ==
X-Authority-Analysis: v=2.4 cv=Z+Xc2nRA c=1 sm=1 tr=0 ts=6a3d3871 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pDBHowQsxXgegazyqkAA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250122
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFJpY2hhcmQg
SGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaCB8ICA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgfCAgMyAr
KysKIHRhcmdldC9oZXhhZ29uL21hY2hpbmUuYyAgfCAzMiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vaW50ZXJuYWwuaCBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgKaW5kZXggNWZjODM3
YWUyMjkuLmNkMDZmZjQxZDRmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CisrKyBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgKQEAgLTMxLDQgKzMxLDggQEAgdm9pZCBo
ZXhhZ29uX2RlYnVnKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIAogZXh0ZXJuIGNvbnN0IGNoYXIg
KiBjb25zdCBoZXhhZ29uX3JlZ25hbWVzW1RPVEFMX1BFUl9USFJFQURfUkVHU107CiAKKyNpZm5k
ZWYgQ09ORklHX1VTRVJfT05MWQorZXh0ZXJuIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0
YXRlX2hleGFnb25fY3B1OworI2VuZGlmCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBkMzBlNWI2NGVhYy4uMzA1
OTE5NmJjYWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCkBAIC0zODIsNiArMzgyLDkgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVf
Y2xhc3NfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKICAgICBjYy0+Z2Ri
X3N0b3BfYmVmb3JlX3dhdGNocG9pbnQgPSB0cnVlOwogICAgIGNjLT5nZGJfY29yZV94bWxfZmls
ZSA9ICJoZXhhZ29uLWNvcmUueG1sIjsKICAgICBjYy0+ZGlzYXNfc2V0X2luZm8gPSBoZXhhZ29u
X2NwdV9kaXNhc19zZXRfaW5mbzsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGRjLT52
bXNkID0gJnZtc3RhdGVfaGV4YWdvbl9jcHU7CisjZW5kaWYKICAgICBjYy0+dGNnX29wcyA9ICZo
ZXhhZ29uX3RjZ19vcHM7CiB9CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21hY2hpbmUu
YyBiL3RhcmdldC9oZXhhZ29uL21hY2hpbmUuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAw
MDAwMDAwMDAwMC4uMmRkOTU0NjZlN2QKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdv
bi9tYWNoaW5lLmMKQEAgLTAsMCArMSwzMiBAQAorLyoKKyAqIENvcHlyaWdodCAoYykgUXVhbGNv
bW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorICoKKyAqIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUg
InFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIgorI2luY2x1ZGUg
ImNwdS5oIgorCitjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdSA9
IHsKKyAgICAubmFtZSA9ICJjcHUiLAorICAgIC52ZXJzaW9uX2lkID0gMSwKKyAgICAubWluaW11
bV92ZXJzaW9uX2lkID0gMSwKKyAgICAuZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKSB7
CisgICAgICAgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKGVudi5ncHIsIEhleGFnb25DUFUsIFRPVEFM
X1BFUl9USFJFQURfUkVHUyksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKGVudi5wcmVk
LCBIZXhhZ29uQ1BVLCBOVU1fUFJFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMl9BUlJBWShl
bnYudF9zcmVnLCBIZXhhZ29uQ1BVLCBOVU1fU1JFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
Ml9BUlJBWShlbnYuZ3JlZywgSGV4YWdvbkNQVSwgTlVNX0dSRUdTKSwKKyAgICAgICAgVk1TVEFU
RV9VSU5UMzIoZW52Lm5leHRfUEMsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
MihlbnYudGxiX2xvY2tfc3RhdGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
MihlbnYuazBfbG9ja19zdGF0ZSwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMy
KGVudi50bGJfbG9ja19jb3VudCwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMy
KGVudi5rMF9sb2NrX2NvdW50LCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIo
ZW52LnRocmVhZElkLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LmNh
dXNlX2NvZGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihlbnYud2FpdF9u
ZXh0X3BjLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UNjQoZW52LnRfY3ljbGVf
Y291bnQsIEhleGFnb25DUFUpLAorCisgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQorICAg
IH0sCit9OwotLSAKMi4zNC4xCgo=

