Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5A910F9975
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYO6-0008Bu-Vk; Wed, 08 Apr 2026 15:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAYK7-00028d-44
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:12:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKPJ-0005d3-C4
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6383LaqQ2412322
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mLEQN0ORwCpGaFZFwS98dzL1dd7XNm783qOe+zmq5uE=; b=jMhhsQFq3a/LVKgy
 6R1fIR2K/ySL3el4Nk4fuZs5P6kYOM8yBNbDhI2NTImXnhFaxeiyb1xxQp4gxhGQ
 YnqEJqm1YI67ouKZjnYB3VYKso6bkFI7cKK0J5hwejhP5S5RrCpZku/tAiDtcl+t
 o6T0RsZuMI20hDv2SMKRl5n/Y/TGogC2OynHZRHUSfiBGn5J0YF7gkukIwQNK/7z
 hCFhSA5JD011kjRrTYv3FF9StFzIckNfgZnnX9P6CgFOrqAIaEtwjvwnSttoHSzV
 2qlyKLYbs21zgX83wiGxzSZhG/PWWaI3MC/fJbdcV2DjRkeEvfoIC8KnJ93pzPz8
 cRZABw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd61v9x78-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:37 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12737f276a2so9127085c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622036; x=1776226836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLEQN0ORwCpGaFZFwS98dzL1dd7XNm783qOe+zmq5uE=;
 b=h0tfuc4zxxlGK1alRuzCIotrj41wAo5AM6UxvMDBDoKT0cxVgfa1uNkEvrGSF91NHX
 NuJQW8mbjGf0Y303/3XGa/BjZIIo51+pVKUPBhzffa0L6exl4C9u7WFEbyzCtCJeIG31
 U3wWLXDFrIT4I0VQYcP0h/5evmvg3bUY0eZ4aL4tOiMnCAv0xpRcLfG/hZt5NVqGNgRw
 it12kSLwja6Ee4ZKtx3tzT8tszkFzW7+pGTAzkynLhLIHQYoHcPJ89ZVBs7gEKIafuy/
 yo+i5OXW3Zr0eCoKYytVFd8TiSsNiraYKoYyKE3dSCy2O4nVWVeg7KB506/fwDz73uwh
 aoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622036; x=1776226836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mLEQN0ORwCpGaFZFwS98dzL1dd7XNm783qOe+zmq5uE=;
 b=T+gH5l8WRq6U0jTfEmH2et7b0LmA2Rn6yDsm0tCQwShwGL1DzuTKKa1HDzM6XvDFNb
 VNBsG6goCgXaUVCx8fXjXDsYi09t/OowX5tbCJmHphBs+2BgkU5jISdoYdww85/euayN
 JPqNqCrXJwYUgevEKM1ivYJ1GatCZZGdmiKz39a5T8ylB9D57eR5+cecDx9SGAin3ZOj
 fnkmeDIOV4ksWdgjctY2vHafDSlzrYvcUvYbvwrzSIoWw7WdEio8ivfP2YI9zxBc7n5r
 FZPY38fQIQLa0ddMUa/6t89o2aLVEVtpfXyuUgU37Z0+GQ1ViNaMAu1ltsIMo9rxcBO3
 T8Ug==
X-Gm-Message-State: AOJu0YyWnkIwEus0zROWyN7Vdv2Go/RuwjA22Lwqobt0NF6bK/b8i7uZ
 V45y8EsJNoGRXvvILzbjyJVT3VJvKaP1Weqa2efJpR7E8esdXlqKgAMD5QUb0ibAuARPhOBzany
 XqzpZDIIUyZb70Smq0fU3lHWkfOThZgRO82tfMKhhPpncnBXCJOBzgq2dcb5vc6XAhg==
X-Gm-Gg: AeBDievjpvFti070gouoT7IPoWLc1qscfum25wocng3M0lPL7KTSkYPYiyOs7TIDa0F
 al8uE6aurQo1TxigEK5hFyE92xs/wnIAU5CV8Ntto/rDQpoScBXR2H3zVB5sSWWfnG3g9TqeOS3
 QWBy4aZO+DKh2Z4Bs1KahB0lr0+jvpOYmGgJioOarUm60qja5nWIDhTPs/m8toXkblLInReEZre
 lhSe7EfZpuLMvGh9kxlQKFFs5McXjRP3HqsDAmhidQe9Zy76z7S3FaS9LfbYdq7jjLWqz25OCy7
 Yvmv0rjZY36rDzvOXpC0xY0/o922u/nxGkvUkeEGayMC19NRiulMS7LtTctDLGCupHlOk11e9qX
 h+f11WEKgtk8Eikbv4i0QqxxLjVljTqMPqWB0FUVW+aX5/TBJMgYMry9feF/QvqF+M+M7nQ==
X-Received: by 2002:a05:7022:6881:b0:128:d39a:b141 with SMTP id
 a92af1059eb24-12bfb745afcmr9915929c88.17.1775622036332; 
 Tue, 07 Apr 2026 21:20:36 -0700 (PDT)
X-Received: by 2002:a05:7022:6881:b0:128:d39a:b141 with SMTP id
 a92af1059eb24-12bfb745afcmr9915919c88.17.1775622035810; 
 Tue, 07 Apr 2026 21:20:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 27/28] target/hexagon: Add support for loadw_phys
Date: Tue,  7 Apr 2026 21:19:52 -0700
Message-Id: <20260408041953.1899532-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX+B+RLKzVc9QZ
 scMnrn3EwzBrgW0r9Mp5lrU71xZy8Jxz3egEATc03DD2wZVUlvzr9AUDgus0iLadImm42n7/5cq
 0Ubh+Cv7oITaQ1VmWyFG5OtyuRSHSk04wHb7zkuiLoqatzI1j1/XqCeF/wOZ2jwJwqHh+FAoZ73
 e/0sC9o8AJMewknGLS81TvueLZBWtNpaNRQNjhqbAD82tJPeg4D4vQPGcMNpASuFPH8tO0zBJ2k
 9EYiV0x6lE4eMR3hlnHmMUtp7rkoaYM1JOEOhQXYGo7tPOaMxCfmTvt3PqA2bnWv4BDPUL4S/uy
 cLf54wZ2klVMokoVE2TlFIDLzo8MlPBx6OHus73P2K2nMK8h5zIAXZpmmCZTrd9oDIOrvUXzFO7
 smlznUO4/KP2YFK9h145iRXu+PkHknwpvm/yEss6tP25EvX6BTgD1ZN/3igXjYG8FNEHNG8KHdS
 CUX8bvvTl+tpx0URqCA==
X-Authority-Analysis: v=2.4 cv=FecHAp+6 c=1 sm=1 tr=0 ts=69d5d795 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=M_0_kNSAHlZdZebFLzYA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5HX42hK5gCywPOMdM_Cy4P_LAUwVU-NQ
X-Proofpoint-GUID: 5HX42hK5gCywPOMdM_Cy4P_LAUwVU-NQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgICAgICAgICAgfCAzICsrKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5j
b2RlX3BwLmRlZiB8IDEgKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmICAgICB8
IDMgKysrCiAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5
CmluZGV4IDk5ODZmNDcxMTRlLi44ZWY4ZTM2ODUyYyAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0y
NjQsNiArMjY0LDkgQEAgZGVmIG5lZWRfc2xvdCh0YWcpOgogICAgICAgICBhbmQgIkFfQ1ZJX0dB
VEhFUiIgbm90IGluIGF0dHJpYmRpY3RbdGFnXQogICAgICAgICBhbmQgKCJBX1NUT1JFIiBpbiBh
dHRyaWJkaWN0W3RhZ10KICAgICAgICAgICAgICBvciAiQV9MT0FEIiBpbiBhdHRyaWJkaWN0W3Rh
Z10pCisgICAgICAgIGFuZCB0YWcgIT0gIkw0X2xvYWR3X3BoeXMiCisgICAgICAgIGFuZCB0YWcg
IT0gIkw2X21lbWNweSIKKyAgICAgICAgYW5kIHRhZyAhPSAiWTZfZG1saW5rIgogICAgICk6CiAg
ICAgICAgIHJldHVybiAxCiAgICAgZWxzZToKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2lt
cG9ydGVkL2VuY29kZV9wcC5kZWYgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAu
ZGVmCmluZGV4IDA0ZTkxMWY1OWM4Li4xYzY0NDk1ZDUxOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvZW5jb2RlX3BwLmRlZgorKysgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRl
ZC9lbmNvZGVfcHAuZGVmCkBAIC0zODQsNiArMzg0LDcgQEAgREVGX0VOQzMyKEw0X3JldHVybl9m
bmV3X3BudCwgSUNMQVNTX0xEIiAwMTEgMCAwMDAgc3Nzc3MgUFAxMDEwdnYgLS0tZGRkZGQiKQog
CiAvKiogTG9hZCBBY3F1aXJlIFN0b3JlIFJlbGVhc2UgRW5jb2RpbmcgKiovCiAKK0RFRl9FTkMz
MihMNF9sb2Fkd19waHlzLCAgICAgIElDTEFTU19MRCIgMDAxIDAgMDAwIHNzc3NzIFBQMXR0dHR0
IC0wMGRkZGRkIikKIERFRl9FTkMzMihMMl9sb2Fkd19sb2NrZWQsICAgIElDTEFTU19MRCIgMDAx
IDAgMDAwIHNzc3NzIFBQMDAwLS0tIDAwMGRkZGRkIikKIERFRl9FTkMzMihMNF9sb2FkZF9sb2Nr
ZWQsICAgIElDTEFTU19MRCIgMDAxIDAgMDAwIHNzc3NzIFBQMDEwLS0tIDAwMGRkZGRkIikKIApk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmIGIvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCmluZGV4IDUzMTk4MTc2YTk5Li40ZTFlNWQ1MzI2ZCAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2ltcG9ydGVkL2xkc3QuaWRlZgpAQCAtMjAzLDYgKzIwMyw5IEBAIFE2SU5TTihT
Ml9zdG9yZXdfbG9ja2VkLCJtZW13X2xvY2tlZChSczMyLFBkNCk9UnQzMiIsIEFUVFJJQlMoQV9S
RUdXUlNJWkVfNEIsQV9NCiBRNklOU04oTDRfbG9hZGRfbG9ja2VkLCJSZGQzMj1tZW1kX2xvY2tl
ZChSczMyKSIsIEFUVFJJQlMoQV9SRUdXUlNJWkVfOEIsQV9NRU1TSVpFXzhCLEFfTE9BRCxBX1JF
U1RSSUNUX1NMT1QwT05MWSxBX1JFU1RSSUNUX1BBQ0tFVF9BWE9LLEFfTk9URV9BWE9LKSwgIkxv
YWQgZG91YmxlIHdpdGggbG9jayIsCiB7IGZFQV9SRUcoUnNWKTsgZkxPQURfTE9DS0VEKDEsOCx1
LEVBLFJkZFYpIH0pCiAKK1E2SU5TTihMNF9sb2Fkd19waHlzLCJSZDMyPW1lbXdfcGh5cyhSczMy
LFJ0MzIpIiwgQVRUUklCUyhBX1JFR1dSU0laRV80QixBX1BSSVYsQV9SRVNUUklDVF9TTE9UME9O
TFksQV9OT1RFX1BSSVYsQV9NRU1TSVpFXzRCLEFfTE9BRCxBX05PVEVfTk9QQUNLRVQsQV9SRVNU
UklDVF9OT1BBQ0tFVCksICJMb2FkIHdvcmQgZnJvbSBwaHlzaWNhbCBhZGRyZXNzIiwKK3sgZkxP
QURfUEhZUygxLDQsdSxSc1YsUnRWLFJkVik7IH0pCisKIFE2SU5TTihTNF9zdG9yZWRfbG9ja2Vk
LCJtZW1kX2xvY2tlZChSczMyLFBkNCk9UnR0MzIiLCBBVFRSSUJTKEFfUkVHV1JTSVpFXzhCLEFf
TUVNU0laRV84QixBX1NUT1JFLEFfUkVTVFJJQ1RfU0xPVDBPTkxZLEFfUkVTVFJJQ1RfUEFDS0VU
X0FYT0ssQV9OT1RFX0FYT0ssQV9SRVNUUklDVF9MQVRFUFJFRCxBX05PVEVfTEFURVBSRUQpLCAi
U3RvcmUgd29yZCB3aXRoIGxvY2siLAogeyBmRUFfUkVHKFJzVik7IGZTVE9SRV9MT0NLRUQoMSw4
LEVBLFJ0dFYsUGRWKSB9KQogCi0tIAoyLjM0LjEKCg==

