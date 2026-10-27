Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40816606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lzscdc6Y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gvdaS8DM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXtR-00036h-HM; Mon, 26 Oct 2026 23:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtN-0002tI-Nb
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtL-000074-Tn
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2EsXi1348690
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 82GTbX6co+CHV5P+y9vLi0NwE9T6aLWO6fg1F5HK7Zs=; b=Lzscdc6Y/y48UAdb
 bS5fDXmfbdsPwsZZYo5/kzhrXauNhsdlZhqSCOyHCBcnJT8fYemwpzdiz5GwZuRi
 gRPbLfcTFEWgA1ofqqAMSVnvcfLBIi8jaPC1bWZ278YCkb9QZNFoonGRw2+K79B+
 ENEnTJK0nBfQSkDWsvAatPWvq5tn0t2V3kci1dng9+e4MH+CBAdtiojAZZI9PHCF
 Kw6FZOg3S5S7Qnp4pnZ0V3Z9LWycYIodd0TtQh/tPmsyV7Yc8hORrKcb/2473NKI
 ZdGUQRsCXKswitQ/2RGfOfwIK5Q7ugXncxri4yTvg6zAbqTijt5G7INrdVR4YEZ9
 aHtzdA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbt8b29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso466211eec.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071816; x=1793676616; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=82GTbX6co+CHV5P+y9vLi0NwE9T6aLWO6fg1F5HK7Zs=;
 b=gvdaS8DMJ9Acw7wcyNFmSCztdPo0j1td5E1jAFQtGZgK7Le0jLBgs6yaYkB4Bpxn/4
 RTk2J9pC2Qm9DWZFgVvrDMeOvcqHJsjsv8YsFSSwItTbcCMtU73s37A5b5RqW2BTmIIm
 tb6apwNtltN/w60csUbQb3JfVkiqd54yFfeOqIyAZ0nnStlKMAAiH27GglSLsslX1FS2
 Y6OJ/aDfxLHZSnoumjEhCpUYNITCOEyESKK62bEO/Gme9Q3EJAJHuvnhwFUHvEycbG6W
 uijMohn/yge8P+Kv51OE9VjcY4lXOG/of59RwKQHcTHXobMzPuAqz4lblxZvyIercw4m
 cOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071816; x=1793676616;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=82GTbX6co+CHV5P+y9vLi0NwE9T6aLWO6fg1F5HK7Zs=;
 b=midJc9wSNupP5ZbCSz+8msv8TfEePiAHP4OEIlzp+DqTzgACktDrFa38nju4JK8mLg
 Dv1vYGuEVIb8N1cvdGL2AgcTJwLncytdngGDlp/5d7/KyNSM7feI66H7Ezhj8H0nzWqs
 L0YwksxArx5Y/Z1BdH4S1qsJDm67ULI7lulUT7Vx+A2fDgFubndx/yR2Mf5Xdu2gwBvP
 /+CjocpOQJBdXs++0zQ4nSHLNV+iPjwyB2L0W1VupxiNxa8OmP2Gguddt2E2WIa85Qpr
 3Wwf/3zvRLF4vVz5MfIoOTT+rq/+lzLKNR4kANYAHbgO56GHAfxMZ9WWfYVfjX26xgxb
 Gp3g==
X-Gm-Message-State: AFq9FYKBu2D+goUP0UfxINiloMYck0lspwHA4t31QcGF4zAQ4uRJmT8M
 8r+F0FSC15BVzQL/W9dHfnpgFBU1GaIRaxR7++ThwoT8/TRoaiTTLtf36U3ovxR9u80xl7CjLuI
 uZe5rz9XcsHCjB0USEdshkWLWUppc79BdDwxT8tdVu3uO0x57i6GMwUkb0Ke3VKn5yQ==
X-Gm-Gg: AYBFou1mxGxNhYBD8Katakd77MUCxQ4IaOlgBdwX2jSmfLSm2+CKaiZr1cgk/rMETv9
 +jIXgFQlKDs0KWELTNWCnjejGtfh+P/+DaKfBJ/HqEpzCMS7UQoKa1VtvuU5tg4L95Dx20dmmUU
 ZZn25uLFZXBCoKfAJ23E1MGBoIBEzABjJy8XaltVGjzvu/IIyDA76w60rF4VSWaV/iomo/XmR/A
 3Y977lWZC1tXXmHOR50jERK8WdeR6OfAKVnZgOlQYigKtmMj+V2lzdlnFtqBiCVTLxeVXmdtq35
 XdEgCg0mTyvY8HfAnsQgvVz4DCtStD4jej+QDF2LoH9twORS0emLJFmdLTMnXQ3eUxg5BPrCOpJ
 gbA/v5y5ZnsHExydkP0EP06kRrpOXWU9qVleyBzuAnoRBDog=
X-Received: by 2002:a05:7022:5f07:b0:17a:e684:b497 with SMTP id
 a92af1059eb24-1992a062241mr11287746c88.5.1793071815759; 
 Mon, 26 Oct 2026 20:30:15 -0700 (PDT)
X-Received: by 2002:a05:7022:5f07:b0:17a:e684:b497 with SMTP id
 a92af1059eb24-1992a062241mr11287699c88.5.1793071814966; 
 Mon, 26 Oct 2026 20:30:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 19/41] hw/hexagon: let a machine place its DDR
Date: Mon, 26 Oct 2026 20:29:05 -0700
Message-Id: <20261027032927.3055166-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX0OWL1orlSY6d
 Nr5nrgJY4G0t/ubYJHWl+MY77aBQirZCa6VwsT4fy8586cGDrci9AlCpmKA6w7QPvSLxViVozwI
 iLiqdv/kBDLhCANJLHcN4BWJzPVyNts=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX8D95Mh1Vco4X
 Rr/D9S7tj7qjSMwbq2S39bH5bJHBHkmChKTSEbndsF3A1QYoCYt2Bq+HYLyFCMNfvMhF+qmkQza
 yW7kU7vRWaJKhpzXK6UNsDYUur3GbZhsUkogKxP6NMCD7xkMRkWOWZESxikkqLj1pCR7PEhfgNs
 0GpRS97n3KxK7ogA7QPgIxTRHqNzXafra7OY+8ynOXboLMVZbhgh061KTlrlcgIl5Y0yPyddMhg
 sw9isadEhrerBpCNVwHM3nUjPaNoWdFuyvnVFkYkZ99dl61nyfQp44M7cM0XQlQgskE0vjrHmLw
 JOA/BSETLmUzNQylfzHQAF+Ly6fXIjvkSM2dEeqcum0uWisRTu6rpK9cJvpNjXqfgS/A8kEMTtW
 FQhi+mNfdtV+SppKmi+CeFHq8dn0e+IUhdr+XtpTOeUF/1t+rqPBZJabKpIjT9vXmRIf7WBtCG9
 N7PQ8tdvh1o3tkRVggQ==
X-Proofpoint-ORIG-GUID: 7p_2TNiDRcjd-XEQwQraOrDXU1gmpVRb
X-Proofpoint-GUID: 7p_2TNiDRcjd-XEQwQraOrDXU1gmpVRb
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae01ac8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=aYFWVRUMB-liYKm9W0cA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270013
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

aGV4X3N1YnN5c19jcmVhdGUoKSBhbHdheXMgbWFwcyB0aGUgbWFpbiBERFIgYXQgYWRkcmVzcyAw
LiAgVGhpcyBpcyBhcHByb3ByaWF0ZQpmb3IgaGV4YWdvbi1zaW0tc3R5bGUgbWFjaGluZXMsIGJ1
dCByZWFsIFNvQ3MgbWFwIGl0IGVsc2V3aGVyZS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBpbmNsdWRlL2h3L2hl
eGFnb24vaGV4YWdvbi5oIHwgMiArKwogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICB8IDQg
KystLQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCBiL2luY2x1ZGUvaHcvaGV4
YWdvbi9oZXhhZ29uLmgKaW5kZXggNzk2MTdhMDY4ZGEuLjAxZWQwM2NjODMzIDEwMDY0NAotLS0g
YS9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdvbi9o
ZXhhZ29uLmgKQEAgLTE0OCw2ICsxNDgsOCBAQCB1bmlvbiBoZXhhZ29uX2NvbmZpZ190YWJsZSB7
CiB9OwogCiBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyB7CisgICAgLyogQmFzZSBhZGRy
ZXNzIG9mIHRoZSBtYWluIEREUiByZWdpb24gKi8KKyAgICBod2FkZHIgZGRyX2Jhc2U7CiAgICAg
LyogQmFzZSBhZGRyZXNzIG9mIGNvbmZpZyB0YWJsZSAqLwogICAgIHVpbnQzMl90IGNmZ2Jhc2U7
CiAgICAgLyogU2l6ZSBvZiBMMiBUQ00gKi8KZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4LXN1
YnN5cy5jIGIvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKaW5kZXggOTgxOGNmNTg4NzguLjM4MmY0
NWJkMDlmIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleC1zdWJzeXMuYworKysgYi9ody9oZXhh
Z29uL2hleC1zdWJzeXMuYwpAQCAtMTM2LDEwICsxMzYsMTAgQEAgdm9pZCBoZXhfc3Vic3lzX2Ny
ZWF0ZShIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsCiAgICAgTWFjaGluZVN0YXRlICpt
YWNoaW5lID0gTUFDSElORShobXMpOwogICAgIE1lbW9yeVJlZ2lvbiAqc3lzbWVtID0gZ2V0X3N5
c3RlbV9tZW1vcnkoKTsKIAotICAgIC8qIE1haW4gRERSIGF0IHRoZSByZXNldCB2ZWN0b3IuICov
CisgICAgLyogTWFpbiBERFIuICovCiAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmaG1zLT5y
YW0sIE5VTEwsICJkZHIucmFtIiwgbWFjaGluZS0+cmFtX3NpemUsCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmZXJyb3JfZmF0YWwpOwotICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lv
bihzeXNtZW0sIDB4MCwgJmhtcy0+cmFtKTsKKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdp
b24oc3lzbWVtLCBtX2NmZy0+ZGRyX2Jhc2UsICZobXMtPnJhbSk7CiAKICAgICAvKiBDb25maWct
dGFibGUgUk9NIGFuZCB0aGUgYmxvYiB0aGF0IGJhY2tzIGl0LiAqLwogICAgIG1lbW9yeV9yZWdp
b25faW5pdF9yb20oJmhtcy0+Y2ZndGFibGVfcm9tLCBOVUxMLCAiY29uZmlnX3RhYmxlLnJvbSIs
Ci0tIAoyLjM0LjEKCg==

