Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5E1FD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsZ-0000z1-Ru; Wed, 11 Mar 2026 00:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsY-0000yA-5y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:09:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsU-00007P-Gd
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:09:01 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B2VNnA1572930
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mLEQN0ORwCpGaFZFwS98dzL1dd7XNm783qOe+zmq5uE=; b=lB4vWQsXwWUwNXzw
 Wpt3jk6TDeXmqC+XqViDwqI4FT810NsYcQcKLgDdWAnG0sy+nsgJZrihGxTykK8u
 hZGgpK3YodNqyp/WIrDN5A+ExgfpQ1zxIxdJjNnV9NZJhWKiLCGcG79YiYCJmlBa
 4rxcs/FaV4SV90hWYdQdtIce6HmfeFzehEKp5oEDDJ17qg0la+1diosK3kWekeT5
 kEvpR6cQNUp552J6fg5fWJwT+gYSmmoAzXmRQ9uOHzOgcfRlNtbmedL0DG/O0OGo
 cF5Kk4KH33cmqNA+9l9HG/sRuYL4GZAmMivX4uSWWJccTcsb8GmR2rVM6i7az3HG
 /JKT6Q==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqgk9v47-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:47 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-415e1ea16b4so88401450fac.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202127; x=1773806927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLEQN0ORwCpGaFZFwS98dzL1dd7XNm783qOe+zmq5uE=;
 b=SXUDm0OLcb1xsHF25uvWw/IkEwbbKYfRZI1S+zM8qwFqo3rQAqaac2Zd/uBnpOt6C4
 Guk3VL3tESsKrU8G9/n/1lp4Ug5u7z7tBF5pgHptCH4eTSfn0WGEVdfKLBiNDVeSDfnK
 MFCEyiBKZeFxaRursw1i/Q+oaF0PpF1jrbtbu8OqtZCR8DnW2Vw2QL1gU2eUGM3jmlFO
 j7ZOHKAe2x1CvYIGi5HWjb/wL3Un3F9HcAdIy9YeUgW5XYKAgh3xSjV0MsGUXKymTbXT
 QajZNU1PC17L2P8zTWNhoJYg1by2qJkSn9O0v2SyCRvvUa2IC0vI3B0TRQNaLDGtvcrq
 akiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202127; x=1773806927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mLEQN0ORwCpGaFZFwS98dzL1dd7XNm783qOe+zmq5uE=;
 b=CzsKlPR0+eAf0Tigw3cbtIv+d2WtIds5IafOZ6mssqhqzg77/kd0o+YoO07tL02CrV
 hvSpKJbWcL8ankKDUgR9n/K6+TurxAVIOe/N2MmB0EXaJ8KMSMcC9FKYBfc+r7pwPXrq
 WErbVuVNsjlwtSdODkEkQuFvzuamML1lZQu3TPAK+xrp5mNT5H0UmvFKLvo8fao73107
 BH1a2hO4XpmVMfINqHKO6O7FMhULIBDkDYIkjtV/kmWN49nC9vyC++krnNVj6wweX624
 D3yEFxYchtKJ1TujljaScW75NaYQ+YQVLEnneF7Ky/bpGblFEGv1F3sXwDSKwhTESCOo
 C5sQ==
X-Gm-Message-State: AOJu0YzXPs/FnMEyrusIxJxjAMwxwuUTzh/Kjsrfip+6ZeRKiyXMHQX2
 JDWqX39+83HoAy9LpuI2rA+AojevFmAPVyXna1SsLRVoQmeX4xQzyNj68qGXgpff2Qu5NrPUKJ2
 w/X6qBJfBsqEuGiabsNdQKDFdKgyNoBn5dZgiwj0RC9IdybVWM+8bXPxecmRFIl++8A==
X-Gm-Gg: ATEYQzwZE3m2neVjBkvN39t/ciMIJf4Ywy8PQ2f6/ixEtHEl29T392LFzfE6t5CkudB
 XfdG1iiPunYQGbNKwz/MtrZJhKNzMMgHj9aR3m/9j+ZEFtD+wFmU7V9ZdszcDtcnab2SfpJmGHi
 ddDT2aMH9sWAc1PW+ZAD5jIa0mxQy30fC7GpBCCLvcEbz1fPgS85NZsXVgwGiE7a8jl2rMIuY8y
 tuIysyvRkeww6MxgEWgSJJDxk9V6T9NLs9LwTw9u35mVOo6c85cv0F1t6pze4qAtV6TJ9/QM5Z0
 s5mAgOzu36THcdtTErxor35lpujuIEvOpc6QmhoY/BhgrZgSkquc7YlFrzbkZI457nPwWDWJNis
 JF2ZvQiU/+fuk6G4/JUZjlkFXBgG3kdRWcNOT46lNO2H5mWdZhDIY89jfJhEjJab3hyozpA==
X-Received: by 2002:a05:6870:2197:b0:40e:e7d4:970a with SMTP id
 586e51a60fabf-4177ca9d4cemr899921fac.31.1773202126968; 
 Tue, 10 Mar 2026 21:08:46 -0700 (PDT)
X-Received: by 2002:a05:6870:2197:b0:40e:e7d4:970a with SMTP id
 586e51a60fabf-4177ca9d4cemr899905fac.31.1773202126554; 
 Tue, 10 Mar 2026 21:08:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 30/32] target/hexagon: Add support for loadw_phys
Date: Tue, 10 Mar 2026 21:07:56 -0700
Message-Id: <20260311040758.1068731-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: dvMMMhTlzCihfFoh7vtprd6tfpOD18Vn
X-Proofpoint-ORIG-GUID: dvMMMhTlzCihfFoh7vtprd6tfpOD18Vn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX86GoRp9j7BUk
 MmZZZFD+GK/rV49A+83dlDCrThEM/Mq/N8HbghogEHyr7AkIeaC3g754kMQ7/gsqNn2Ryt3T0OG
 ZdPYttbgZVF88uJvl4qkRcifRzvPU+q1OFT0665siiPrvuZUgAF5irqX9SBwJxZyM937/lr1dR9
 AV+zfioEBgwwirFGEKI4j+KAafGstHt+ycVvlopqZ8GYf6Yo+lhilYDDRkXnkXCQVT1gNEw7Wss
 Rr6i6zx/Wci9hIn1idd8kgsJC7U+9UFQWfMS6OKWumjcQit8gfYb8ZJbbGcFmF8J8TPHeSay2Tp
 hhqwCLBz9uSIAvWfKBS/KQ2nxLdQjOwO8VPKJjG/ZLJfmIW2C0RpP0Wd9Ge5hbnUnmBHTZ/FQA7
 7B3R8InZZD53YeWgim/JtXzYNd02GnXMMSBadwSOUDGtWyRI+f8iZspBlVmsMac1nRDEb6vPX0z
 fKUpErP9IBGM5NM0gHQ==
X-Authority-Analysis: v=2.4 cv=M4JA6iws c=1 sm=1 tr=0 ts=69b0eacf cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=M_0_kNSAHlZdZebFLzYA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
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

