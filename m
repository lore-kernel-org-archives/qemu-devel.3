Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5EFC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 23:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwpPy-0007xi-1N; Wed, 19 Aug 2026 19:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwpPs-0007x6-9q
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 19:09:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwpPq-0000We-Os
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 19:09:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JL7jYt1457426
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 23:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OB/rBM+QhR7yev6pFNMN2+0uP+uZL4qKHe20nsqrzso=; b=TNru0BgaN2jH/evr
 1a1tqUdKP9V16f/7iFXuCRCO72WaEuQlS/bxI0Xop3ibmMI8Mm+WorcT/5rEfp7G
 mu5nvdmhxHXJHeNdyRQPQG0xkIfVAlWZMWHH7prL+dQcTtjACD7ziDJ/akpcSHxG
 wr3WLSNDN4eSbANmC8JOk1+zT738i2KF1T5YnUmF21wdIxCiwTBodVttrW3IOg6U
 ole5zd2l2NOefX+BACELocFAx6ECPXuWtZ7M1fQMHvsRI77dY4gxoDvXnUypvgLw
 Ijyefw6Y/9EWsnbV3exl3DlMx37U+MI5wuEq6GDE45IVpe+YY7pkztOm4bhPc7VB
 vVgHqA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es4a0bc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 23:09:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so2972796a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 16:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787180989; x=1787785789; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OB/rBM+QhR7yev6pFNMN2+0uP+uZL4qKHe20nsqrzso=;
 b=QPU2Oy/IxO6eQ+QmS6YlyY3Vigw+ijs/d4nVAnig0hi8bdNNxiKMH6Ivc16f8PC5ar
 t4XgLuGBW2Zm9mMrhYPeFRyfzXPxaI2tJFCacyQdTB0H5SLXm+jzD3j5o+X++3MUs5Cy
 b9jwl27XNFNxgodqk+DNjA8oXEgI6ATHxGyc/KSIIz5MXJkd5lJLAL+HXYcqb8kVsga+
 Lcvu9rYyJUhIa6xdUYjQj1pejotH4SsvbXb+mHI3RNtI3aijMVBcMsZ0ky4TUAoPQG+P
 PxTnXpnwrf3YzdNvp/RzdIRQmeYoKvJMGECIzTUbGdbBP95n5ZIpmojC2Q+TwYq/x2+H
 2K+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787180989; x=1787785789;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OB/rBM+QhR7yev6pFNMN2+0uP+uZL4qKHe20nsqrzso=;
 b=ekyTy4wkdRdMafPZf7PEwd4uLWJG6SqmERkyMQwZR4kc93CZg1IrfNQhRkCj1GenlW
 sfYxxU+Xhj0PN36n60Ue6mXCj4yoQjjhgg/fyf4gvUvZQ8G+5XIdK7GANGjUjBpRXRgE
 vTFtc8y9jzvc8LLaoGoLdC0Z8zP4mPSGnp+stN5YZhKnnEwKfAz+O9cNNU2Bo4WblIe3
 e0YD+wYYxJdnDU3pS1ExBZjZ3m6QsW3jOdcDLSOxokqiuT4QFJbC1eznpmuIqjf0/Ls/
 beEGJAi81k5H0+f4r0y7IQj7XTbq4UwszHFHzBUeokV1N0J7rfMfkgQKxK1T16JhzkPb
 XJnQ==
X-Gm-Message-State: AFuF++l77z5BmvHfAedabRwGAOkVpwM3HFtk9UnzR5yqNMQYMJnJeRkC
 HtfsJF1AjyVizPvOCNx1YsGPsB9GINFowHA/HBH6ziolaEUmvhhwYZLEBPhG2aLkObRdmiPwJl+
 9UshI2dTVGrdOv9awqn8f4/LRexBAFRr9LXhusPsUqxAoZ5aQ1h7IB+T42J2wVupUTw==
X-Gm-Gg: AR+sD12XsIytn66iVleh7vTjuShR2VGxVJWm2yc+mtjCAzrBaqVadaXp+G1d8vkeH7i
 89+iz2FqnFdmNXB6C+IMQNmrqCw+EoJ7TlHOmnEP9QdvBRLKJWZ1/AhaR7x7AKjHo87AZnqqJTy
 Rr2gW5ZaCMarJYLf47L2aPNkUsjFk7reGOyCo8fknSHYti2Yax7ln5XK9Fx7FleJbcFR0YzWd0K
 0G4PKHesCYBeAlZrvkS2kZSi3RNqaaMf8RYDA8R7+ime86BHaSbfZ+sS9V4ehWrPa2vn9Ztlg++
 dMN88QSyh4k6Lbaze7Qtz0Wy2/enWjFmOCQvm9/iuLQ7hMOXmp0hOypqufiwcBq6M9MItUp9k+q
 JoDn4gwkUk46fAL5omV7iyByr1w7U4d0WHbZhzN7aSNN1W0tm
X-Received: by 2002:a17:90b:1e4a:b0:37f:c97a:939f with SMTP id
 98e67ed59e1d1-39580ace5fcmr14459200a91.7.1787180988827; 
 Wed, 19 Aug 2026 16:09:48 -0700 (PDT)
X-Received: by 2002:a17:90b:1e4a:b0:37f:c97a:939f with SMTP id
 98e67ed59e1d1-39580ace5fcmr14459129a91.7.1787180988231; 
 Wed, 19 Aug 2026 16:09:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae143edsm18988944c88.10.2026.08.19.16.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 16:09:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 2/3] target/hexagon: fix HVX scatter/gather region-length check
Date: Wed, 19 Aug 2026 16:09:38 -0700
Message-Id: <20260819230939.466856-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819230939.466856-1-brian.cain@oss.qualcomm.com>
References: <20260819230939.466856-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: NJObgYfyDd1tIznC-zGaiKoUU9QvSNKZ
X-Authority-Analysis: v=2.4 cv=PZXPQChd c=1 sm=1 tr=0 ts=6a8637bd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Qw7tgrHAXXgfsE_xu_kA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE3NyBTYWx0ZWRfXx+Cm+cWxV28T
 NQUJdbDMhrpg8UkH9TL0Ef3XlCjJL43kGSMcSrG8obV56w2qfEWGQHUQ09tt5Ur2XxM0PkCpn4F
 yn3O0FpTaq78TC6J+A3r6l52drUySFw=
X-Proofpoint-GUID: NJObgYfyDd1tIznC-zGaiKoUU9QvSNKZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE3NyBTYWx0ZWRfX1/QtwlTNE3cX
 7eg+3axGbIo5/H3cKO4T57tvfpEq4bSSLBdabi4VhNb3NtlOcNJ0PCoEG/FzSultchSkYcLw9N9
 /1Halv+7SZzUN0pXD6WK6dAW77TOkTzGhV2Xb8e6xWyUugEAB2EX/c2qiQgBHH6DSvlagkiYKsW
 rddHcGtfDxL+E13PwiIF2+638zldbOpVj39SmW0GIJfGaNwjT9LcTRBuRPz5PhkL8YV7v+5BV/Z
 xzQlA+smAgWyCoL0ySqegKo+P00SHdf/f5KhelhWj/QQIT+iHn7zdQ+fBvMAicIkTqbrcbeBZG3
 bZcp9ln7qlrDYmoYoIqFf0772nUUyEF0uUSodlYZrL81GPZmxTrgw0UAIDzeZ1GuGPcW82+vE0U
 1LTk8bb2WeIa4DmZluzLR6I66lwrnLtqkullNe4Ve3eqakC0Y2fqyJ3DphtnD2jRbODgO3yH3p0
 ZAuphSzbLpkccvBjWZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190177
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
Z3RoIGRpcmVjdGx5IGluc3RlYWQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5j
YWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmgg
fCAyMCArKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21tdmVjL21h
Y3Jvcy5oIGIvdGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmgKaW5kZXggMGVkMzU3MjBlZWEu
LjdlZTZmNWU2MmZiIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tbXZlYy9tYWNyb3MuaAor
KysgYi90YXJnZXQvaGV4YWdvbi9tbXZlYy9tYWNyb3MuaApAQCAtMTMwLDkgKzEzMCw5IEBACiAg
ICAgZG8geyBcCiAgICAgICAgIGludCBsb2dfYnl0ZSA9IDA7IFwKICAgICAgICAgdGFyZ2V0X3Vs
b25nIHZhID0gRUE7IFwKLSAgICAgICAgdGFyZ2V0X3Vsb25nIHZhX2hpZ2ggPSBFQSArIExFTjsg
XAorICAgICAgICBpbnQgaW5fcmVnaW9uID0gKE9GRlNFVCkgPD0gKExFTik7IFwKICAgICAgICAg
Zm9yIChpbnQgaTAgPSAwOyBpMCA8IDQ7IGkwKyspIHsgXAotICAgICAgICAgICAgbG9nX2J5dGUg
PSAodmEgKyBpMCkgPD0gdmFfaGlnaDsgXAorICAgICAgICAgICAgbG9nX2J5dGUgPSBpbl9yZWdp
b247IFwKICAgICAgICAgICAgIExPR19WVENNX0JZVEUodmEgKyBpMCwgbG9nX2J5dGUsIFwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGhleGFnb25fbW12ZWNfZ2V0X2J5dGUoJihJTkMpLCA0
ICogSURYICsgaTApLCBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgIDQgKiBJRFggKyBpMCk7
IFwKQEAgLTE0Miw5ICsxNDIsOSBAQAogICAgIGRvIHsgXAogICAgICAgICBpbnQgbG9nX2J5dGUg
PSAwOyBcCiAgICAgICAgIHRhcmdldF91bG9uZyB2YSA9IEVBOyBcCi0gICAgICAgIHRhcmdldF91
bG9uZyB2YV9oaWdoID0gRUEgKyBMRU47IFwKKyAgICAgICAgaW50IGluX3JlZ2lvbiA9IChPRkZT
RVQpIDw9IChMRU4pOyBcCiAgICAgICAgIGZvciAoaW50IGkwID0gMDsgaTAgPCAyOyBpMCsrKSB7
IFwKLSAgICAgICAgICAgIGxvZ19ieXRlID0gKHZhICsgaTApIDw9IHZhX2hpZ2g7IFwKKyAgICAg
ICAgICAgIGxvZ19ieXRlID0gaW5fcmVnaW9uOyBcCiAgICAgICAgICAgICBMT0dfVlRDTV9CWVRF
KHZhICsgaTAsIGxvZ19ieXRlLCBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZXhhZ29u
X21tdmVjX2dldF9ieXRlKCYoSU5DKSwgMiAqIElEWCArIGkwKSwgXAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAyICogSURYICsgaTApOyBcCkBAIC0xNTYsOSArMTU2LDkgQEAKICAgICBkbyB7
IFwKICAgICAgICAgaW50IGxvZ19ieXRlID0gMDsgXAogICAgICAgICB0YXJnZXRfdWxvbmcgdmEg
PSBFQTsgXAotICAgICAgICB0YXJnZXRfdWxvbmcgdmFfaGlnaCA9IEVBICsgTEVOOyBcCisgICAg
ICAgIGludCBpbl9yZWdpb24gPSAoT0ZGU0VUKSA8PSAoTEVOKTsgXAogICAgICAgICBmb3IgKGlu
dCBpMCA9IDA7IGkwIDwgMjsgaTArKykgeyBcCi0gICAgICAgICAgICBsb2dfYnl0ZSA9ICh2YSAr
IGkwKSA8PSB2YV9oaWdoOyBcCisgICAgICAgICAgICBsb2dfYnl0ZSA9IGluX3JlZ2lvbjsgXAog
ICAgICAgICAgICAgTE9HX1ZUQ01fQllURSh2YSArIGkwLCBsb2dfYnl0ZSwgXAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaGV4YWdvbl9tbXZlY19nZXRfYnl0ZSgmKElOQyksIDIgKiBJRFgg
KyBpMCksIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgMiAqIElEWCArIGkwKTsgXApAQCAt
MTcwLDExICsxNzAsMTEgQEAKICAgICBkbyB7IFwKICAgICAgICAgaW50IGkwOyBcCiAgICAgICAg
IHRhcmdldF91bG9uZyB2YSA9IEVBOyBcCi0gICAgICAgIHRhcmdldF91bG9uZyB2YV9oaWdoID0g
RUEgKyBMRU47IFwKICAgICAgICAgdWludHB0cl90IHJhID0gR0VUUEMoKTsgXAogICAgICAgICBp
bnQgbG9nX2J5dGUgPSAwOyBcCisgICAgICAgIGludCBpbl9yZWdpb24gPSAoT0ZGU0VUKSA8PSAo
TEVOKTsgXAogICAgICAgICBmb3IgKGkwID0gMDsgaTAgPCBFTEVNRU5UX1NJWkU7IGkwKyspIHsg
XAotICAgICAgICAgICAgbG9nX2J5dGUgPSAoKHZhICsgaTApIDw9IHZhX2hpZ2gpICYmIFFWQUw7
IFwKKyAgICAgICAgICAgIGxvZ19ieXRlID0gaW5fcmVnaW9uICYmIFFWQUw7IFwKICAgICAgICAg
ICAgIHVpbnQ4X3QgQjsgXAogICAgICAgICAgICAgQiA9IGNwdV9sZHViX2RhdGFfcmEoZW52LCBF
QSArIGkwLCByYSk7IFwKICAgICAgICAgICAgIG1tdmVjX3NldF9ieXRlKCZlbnYtPnRtcF9WUmVn
c1swXSwgRUxFTUVOVF9TSVpFICogSURYICsgaTAsIEIpOyBcCkBAIC0yNDksMTAgKzI0OSwxMCBA
QAogICAgIGRvIHsgXAogICAgICAgICBpbnQgaTA7IFwKICAgICAgICAgdGFyZ2V0X3Vsb25nIHZh
ID0gRUE7IFwKLSAgICAgICAgdGFyZ2V0X3Vsb25nIHZhX2hpZ2ggPSBFQSArIExFTjsgXAogICAg
ICAgICBpbnQgbG9nX2J5dGUgPSAwOyBcCisgICAgICAgIGludCBpbl9yZWdpb24gPSAoT0ZGU0VU
KSA8PSAoTEVOKTsgXAogICAgICAgICBmb3IgKGkwID0gMDsgaTAgPCBFTEVNX1NJWkU7IGkwKysp
IHsgXAotICAgICAgICAgICAgbG9nX2J5dGUgPSAoKHZhICsgaTApIDw9IHZhX2hpZ2gpICYmIFFW
QUw7IFwKKyAgICAgICAgICAgIGxvZ19ieXRlID0gaW5fcmVnaW9uICYmIFFWQUw7IFwKICAgICAg
ICAgICAgIExPR19WVENNX0JZVEUodmEgKyBpMCwgbG9nX2J5dGUsIFwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGhleGFnb25fbW12ZWNfZ2V0X2J5dGUoJihJTiksIFwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFTEVNX1NJWkUgKiBJRFgg
KyBpMCksIFwKLS0gCjIuMzQuMQoK

