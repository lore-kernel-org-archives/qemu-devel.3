Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA42C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2Tt-00077f-IT; Wed, 12 Aug 2026 02:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Ts-00076p-1S
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Tq-0003oj-Dv
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62boF2190393
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WlqwqNNmlVCwY/HMUFQGFJ6MJ0M1EsGC/8XR8w8/wHU=; b=SMCZMMFIWuLIdDhV
 whvLzGB5Yc3AZL+NM8bVUYcaAY010gl5G3qJJ1fk7mFRfeouTVAcykqGYjRRzghR
 xJvcmNkD0dErnuFMSJ86Z4L5+Ic/ku/IikJXzGrfGFRaeAkNsN1EpJESxvPB4++g
 0w8AEo6rv1ciR34vGSgE4q0iOKdXb7hMxLajt2QQyd1yXovWLmFqB4GBQg02V0+d
 dFoby7C6SxXv8daYGva9MMLURA8IfiDLMSijbxhnVfaIDWAMhfGkXqtkTwYfgXJF
 ChnfhfYLdDZKtSdURWyRY+Os8lUyO9abzBsnGPJ0vYMZDAGPSfVIctOyblL/7nbn
 Ca8Tmw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049g3t3s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e667368f0so1007834a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516224; x=1787121024; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WlqwqNNmlVCwY/HMUFQGFJ6MJ0M1EsGC/8XR8w8/wHU=;
 b=eUkS9Y67iaaa41I9xcyQQUymqxE5E4tH8Nu1TWXsf3gmSrpC/oyHhg9kNDv7JLkX7k
 hUnNP8RgY/7Od4yp527pvwBoRC7sbPofGLMeYth454RE/Ig70H5RAeSD/TvwazVoaONW
 xmceHB+5PPqUVCC3X7YLJ6NbA26WtLTGwVlvGTWI6rgjbzsDwmJfETTEQIaCyf2MmURr
 cR01/iBpepEzbAy3G4UhM+lMoaO4+h3+OxFc7Rhn7pz5qZfaOQA5Pg2g8HCG7GB/qSr/
 95u8ZEkifvQqYuM2bEmeKMRNWjGektY50bOYkOx6lasDZSr59lp4tNbbh8GkxZrgwKOW
 EiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516224; x=1787121024;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WlqwqNNmlVCwY/HMUFQGFJ6MJ0M1EsGC/8XR8w8/wHU=;
 b=PSmyDYmQyodcl3QnuW5eDYyxjApmtCfYUmuT/ZyTkOvodA+Cpv7QzU/LqScOYWKcEV
 PNmwSmEDipfGyOM+dDLauxPqgrFDFlQZSDsAvTnJ+ZRy+daqImg5anacq8OKlqgliL6l
 9gfXtOKsVZ6nOGs/Agy3uMKkK4ikNqh3QcbDJBNvcxQ0Py/rNN+A6BfPEmG484IqIijP
 KtVQmRBVincW/dmhbmEU58cucUC9K/Jtn3tx5LGtRsxTRiZ0Yoe/+rCAu7uTui2VjDCH
 nB5UQ0sxOoCxA7Kws3kmDXi5T/ut0wmi4cjUziAsqZ5NP5D3EApGn/XDzBW6fx+o5ef6
 yRtw==
X-Gm-Message-State: AOJu0YwpkmodHjL8boI61/hECuD2sTug0geWz4e6SuxmT4mWTNQlfJsZ
 YqxBbBc6r/OiyYyVzbu/glCiUjDnlE/FqkLXAxv132vKmfnK7OSH2VLCBEpalCLbME3C17MSSZt
 iihD5GTa5d3ogVQt3R+LSMRgBdcAP+2bBLNQLclmHPnpMfi+B9Vg7TLqbGVvwa/VGRA==
X-Gm-Gg: AR+sD11DyASS7Ync2SC7dA04S9vxD1iUvkKUiqtjLI5pNIuOoD51L/h1GDg5Nkt5FmD
 OBAcrhGwcTryQ18KSGu3E31mN4FquX0L65SIy+deg3QW8mvcKLS7VG7kCaahtGPV9n+EEVpZkZe
 CJ8esPFnaZMndiEIfQ1sGJzlaSEoOt8hPgagbSxSbwyLWlCrNkIFadTvjwjPfUsjjlYq9KRt5lK
 TqH+ne2n/qJ/qNxawQ93QDtbgz0Dp8dLW/QMipeV9RCY25XhfTMjWvxpoOUE3HSm9qzajXO6pVW
 4oPgCNmyUqlcLxMzb/8FvQv/oTJsxOyUw5BcFhPwSwLuS8blg2LAHiOIBHImqGLflwkxFjQZNCq
 0n9EF4/9hqt7zyaBYsLpPL6fg51b2YyVYaZ+J8icppkaC0Q+t
X-Received: by 2002:a17:90b:2b45:b0:380:873:49cb with SMTP id
 98e67ed59e1d1-39301834f69mr3123269a91.21.1786516224412; 
 Tue, 11 Aug 2026 23:30:24 -0700 (PDT)
X-Received: by 2002:a17:90b:2b45:b0:380:873:49cb with SMTP id
 98e67ed59e1d1-39301834f69mr3123214a91.21.1786516223868; 
 Tue, 11 Aug 2026 23:30:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 14/41] tests/functional/hexagon: add arch_tests functional test
Date: Tue, 11 Aug 2026 23:29:05 -0700
Message-Id: <20260812062932.543840-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: ypYTndMp882-pJWRj_eBuROQ1APFb7q0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX21nKsPQUjMoX
 zKeg3jkkcJGnlZPIZyfW2m85HUh0Com/INvOZDxHI8M76zK8Bhp9ITwb7Zxb7Dq69mFLeC46z//
 E3/s01LHmjwfHdS5ddXcAFYy3Q+mHUg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX6Gdi1rDMGWPb
 wEwISKiYk0k07gsjxkQhTGeABDc9pmlmc8NsWhr81zoMl/FGYBCMftABwYiV4YtksBm5pvJ3CKN
 TOPkDRnQlUPPDqbSBPHjqfHds8WrmnkVgAuL5tWlwgsyBTZq0U3EZaP1u5kbhxgFN8GUsoe9xO6
 0AfjFfOzC0M3qTK/hpv6Qbc+Ji1bB2oJ1KYXoUj/UhSUKKpDxPS7qWMaBgJOD0UDL8kKmq/u7Pi
 /hhl4UU8s/+Cvr15A6zoPZkyu70S8aVApyHEc2M2kN9sBZ2mU+CZwhkMos3mYnVF1sPY/wYFiz9
 7rlEqrf2FCpwIUdcY8VFrEIt8cCV9SRojqLCpgpM4FeHAKS+n4B+Ef2c5hyZFjb6GqICEXdepIY
 YfmfM2GvyN59BejGpoOLrbqWwRgxfDJdP+GVLL9IqWcujTaV3SolU50AUt1vAp+aJBLIb3UqeVd
 eVMDuLz+nn/jllT0suQ==
X-Proofpoint-ORIG-GUID: ypYTndMp882-pJWRj_eBuROQ1APFb7q0
X-Authority-Analysis: v=2.4 cv=LIRWhpW9 c=1 sm=1 tr=0 ts=6a7c1301 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bMnCV-8aVPcHOxL5XGsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120049
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

QWRkIHRoZSB0ZXN0X2ludF9zdGVlcmluZyBjYXNlIGZyb20gaGV4YWdvbi1hcmNoLXRlc3RzLgoK
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDgw
NjA0MjcyMy4zNzg1MzY5LTE1LWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbQpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMv
ZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSB8IDYgKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9o
ZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0
X2FyY2hfdGVzdHMucHkKaW5kZXggNTRhMTQxMmM1OTcuLjJiYjM0ZjliOGRjIDEwMDc1NQotLS0g
YS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CisrKyBiL3Rlc3Rz
L2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKQEAgLTUyLDYgKzUyLDEyIEBA
IGRlZiB0ZXN0X2d1ZXN0X21vZGUoc2VsZikgLT4gTm9uZToKICAgICAgICAgIiIiCiAgICAgICAg
IHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF9ndWVzdF9tb2RlIikKIAorICAgIGRlZiB0ZXN0X2lu
dF9zdGVlcmluZyhzZWxmKSAtPiBOb25lOgorICAgICAgICAiIiJUZXN0cyBpbnRlcnJ1cHQgc3Rl
ZXJpbmcgdmlhIHByaW9yaXR5LWJhc2VkIHJvdXRpbmcgdG8KKyAgICAgICAgc3BlY2lmaWMgdGhy
ZWFkcyB1c2luZyBTVElEIHByaW9yaXR5IGFuZCBpYXNzaWdudy4KKyAgICAgICAgIiIiCisgICAg
ICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF9pbnRfc3RlZXJpbmciKQorCiAKIGlmIF9fbmFt
ZV9fID09ICJfX21haW5fXyI6CiAgICAgUWVtdVN5c3RlbVRlc3QubWFpbigpCi0tIAoyLjM0LjEK
Cg==

