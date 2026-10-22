Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5064C606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZZ9q1yKr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FSPjPVj4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK1n0-00055O-BN; Thu, 22 Oct 2026 19:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1my-000557-OT
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mw-00025c-R4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:36 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMFEjL1412559
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eG1B/ezFwlT3Tz2q1Pu/mwn2h8sFjGue/KE6IQS3KVM=; b=ZZ9q1yKrJaEQbLV+
 2Fzay47MQZHZlR0B4eCZxQRX1waFdxrVyp+Ew/bgmS363r2n4EYSb4PDN0kdgu5Z
 rWqEFLOEQ6P003d32Z1uGxa3ukIPBig/AcOxl+a5hi9WeAAQ4NFS3VuqO9NMb1v6
 NcEEsJdsgehJM+8gYKIHXlDdSlTuWBhPJv62cQuqPnc7zqrnrB4jEmUHqvZtOGtN
 6liud0PH49g55yML5qkyaCnq96Ke95izeUOY+9FEOpIHTvMNdf3Ki/H+emq1laIG
 lFYU3EuLOkfXSIwBm52fGF0kp9e1aSlv3bGQej1ZoDwJDeETozFimj0f72DsXWTO
 /0GZtQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0hg6t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:01:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3580c07911eso874695eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792710093; x=1793314893; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eG1B/ezFwlT3Tz2q1Pu/mwn2h8sFjGue/KE6IQS3KVM=;
 b=FSPjPVj4VlEogPwdAD50sI9gH+N2j19rGBwi7EFz8VtduglKHdK+2CuzDYLGqnYb8o
 HjsYcr5haByMqc5luq052hHNnfSq0cf3Adi7R8+3Cn5hybPtyBkpgodORpDQA0KAEwoo
 QQiXG+6EYYP4+vgWMzLwdcPAJczbIh9xhnYYnEsa0vXN+36hopCqifRfe8Q5rM4C6VCv
 owzC6BTt4PgGS+3ueELxlG/P8vMKgzdo5Scn+WPLRXQBaVA/Zq47gebxYLk3eIPm+NO4
 ORg1VEgEz/9WHdJQILpD2TLVyTtiRz6oU2h/FAh327gMF8CWjM4I9NmBKbSv6NqtRaE1
 nzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792710093; x=1793314893;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eG1B/ezFwlT3Tz2q1Pu/mwn2h8sFjGue/KE6IQS3KVM=;
 b=udX29j8w3jFFph/EHt8dHXtcW2Sb2kwYYAFT1abJykvLva3BczghG9h/qMjnMfoTR3
 Fq9mmA7FDJMi1oe3O+5wWfPXCuRe9la8cZLSin6IOzCmkskwBuS4T9oIJYqBzREAYUjY
 MKpjDEUrHSA9LWl64QNhcsYozYSZxGTjeKtV0J067vNIf9Ta2w7jME+pv0VwV4bnhVs9
 AK6/3j3ZEO5gB///1l2qkFUdquYruHNONEK28Swv1J9kw32PNRO8Fk9TbG+KH+JlAQOL
 YeFc8mBDbXiffOwJ5nneIvk1WGxwcjlQqen3LjiFDWdXe57+Bib5CdMwuRbfD3aU1CTp
 iuWQ==
X-Gm-Message-State: AFq9FYLLHCi3kd2wREAAax2EbcZ6xfy2+i4OH6YsIEI5DZJ5e4e9PkZR
 wKTW10UBDm8/CNH8zpLEvNJCZntAZUs4edez9Q1UeCAP3U+KYSJInlGHhOdoSVxeKx6t0pwJFPq
 O1UCqGTt7rPXNJzU57iAIMMuQUzOW5S3jvpFCk3KO/1QuNFsy8IyaktW6nVIMwqt4Dg==
X-Gm-Gg: AYBFou3c7rZ4GOH9A8dL1wKbX9LwfZhI+TE5U6CyQ54gyieY9MUvrqm+1RmyfOlyS1w
 eSti56UnVtGezOxGYs5pXDlPjWFAnS8AcLx8WgNPSQ7fUSJXObiCmWlqbH7XtRqLyMz2Ol6rIJg
 SKJ4+V3nUxmELSKzzj0Vx8yvIbi81CJOWu1mOByNavbCNyD4va5kFQp7ukyDoN3rSrRLBYHsQII
 udwM3yKWi+cZygSXzSznt3Lex3U95gtjhCl+acRwL+1iPjmgVyXYuCsqzvOad7EsfpPWm+DiIdV
 am17bYxQQxi1sSxRASf8NRfQnEa0CicUSXdmisSiXXZlno3TbTeA9LALsE+HpvCJ0I8Rl71cAn2
 6EFpLV5pL/ebDZL7DrsQwJXW+8CgWz3VRa7u33yWry9uuTz5R
X-Received: by 2002:a05:7300:e9cf:20b0:365:f73b:510b with SMTP id
 5a478bee46e88-369d971f2a0mr777125eec.13.1792710092727; 
 Thu, 22 Oct 2026 16:01:32 -0700 (PDT)
X-Received: by 2002:a05:7300:e9cf:20b0:365:f73b:510b with SMTP id
 5a478bee46e88-369d971f2a0mr777077eec.13.1792710091983; 
 Thu, 22 Oct 2026 16:01:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9c0e60dsm1088138eec.2.2026.10.22.16.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:01:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 16/16] BCAIN do not merge - gitlab-ci: enable CI pipelines
 on forks
Date: Thu, 22 Oct 2026 16:00:48 -0700
Message-Id: <20261022230048.2160400-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: jaTdZh-gvVkP6bwDvTtmiA_tp8RPeUFt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX0PlCCOVXjR5Z
 VGyZppwJzJjzxKw9sX/q0Jy0A5N0cIZoIFYTgX7eSsXgPuMO2pzte2SaUYd73N+Zkvbo3zX5SIW
 XpVq9Ux8K1fUDB5xnn0xwHLj8vcudb6lIigvKqdF7g8a49I8/jvvIatocoriFD1qdZe6GyaeV0a
 XqOkhL2UyJax6fabMJPr9wh5QYPeHsSD7OjoYumjakgQVYOCRoFsxtewLSK+utlbcA2QcQlpiAl
 LhVDJfcjKkNOzZ6qbk+rm4ec3lVbLo7mKcuC9sTVJi3BnSRyMVBJw58/sYslU7Dq9SuGmbcAkPN
 FkFdmRfRS3CLtm6fECJq37wHoSxSxDqiCZf5afopAfFciy/c9zS9TFVQhd3iAS/KCZBVgLYeNVX
 iS5kEvbRg59C9jtaEuvqY6s8W6LS2RVmg118Hvcy9SAobyFJOEzG61aH2XRVByw+FV+HjJY77BJ
 BCFvxf/Lo064W5JdUiQ==
X-Proofpoint-GUID: jaTdZh-gvVkP6bwDvTtmiA_tp8RPeUFt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfXyE4VhZV9Tq2G
 j0QxOkdaB5QchJWBITveyMmzQX0wV7jKVKXeH3e03q8HnHKrKJCLMwCKgwYMu2DXKuiRhIIzD5o
 iv8Be4uKhSMu/+E1WpDx2x+nVlfXreE=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6ada95cd cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=80Utp8WvcCC6Q7Ow_PoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220091
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

U2V0IFFFTVVfQ0k9MiBzbyB0aGF0IHBpcGVsaW5lIGpvYnMgc3RhcnQgYXV0b21hdGljYWxseSBy
ZWdhcmRsZXNzCm9mIHdoZXRoZXIgdGhlIHByb2plY3QgaXMgaW4gdGhlIHVwc3RyZWFtIG5hbWVz
cGFjZSBvciBhIGZvcmsuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+Ci0tLQogLi4uL2RvY2tlcmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3Nz
LmRvY2tlciAgIHwgIDIgKwogLmdpdGxhYi1jaS5kL2J1aWxkdGVzdC55bWwgICAgICAgICAgICAg
ICAgICAgIHwgNTggKysrKysrKysrKysrKysrKysrKwogLmdpdGxhYi1jaS5kL3FlbXUtcHJvamVj
dC55bWwgICAgICAgICAgICAgICAgIHwgIDIgKwogMyBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL2RlYmlhbi1oZXhh
Z29uLWNyb3NzLmRvY2tlciBiL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdv
bi1jcm9zcy5kb2NrZXIKaW5kZXggZTA3YTJiZTM3ZTIuLjM5ZjY0N2M3NDNjIDEwMDY0NAotLS0g
YS90ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyCisr
KyBiL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5kb2NrZXIK
QEAgLTI4LDYgKzI4LDggQEAgUlVOIGFwdC1nZXQgdXBkYXRlICYmIFwKICAgICAgICAgZmxleCBc
CiAgICAgICAgIGdpdCBcCiAgICAgICAgIG5pbmphLWJ1aWxkIFwKKyAgICAgICAgY2xhbmcgXAor
ICAgICAgICBsaWJjbGFuZy1ydC1kZXYgXAogICAgICAgICBweXRob24zLXBpcCBcCiAgICAgICAg
IHB5dGhvbjMtc2V0dXB0b29scyBcCiAgICAgICAgIHB5dGhvbjMtdG9tbGkgXApkaWZmIC0tZ2l0
IGEvLmdpdGxhYi1jaS5kL2J1aWxkdGVzdC55bWwgYi8uZ2l0bGFiLWNpLmQvYnVpbGR0ZXN0Lnlt
bAppbmRleCBiMWU5NTM5NWQwYy4uMWYxMmE1ZjFmNjQgMTAwNjQ0Ci0tLSBhLy5naXRsYWItY2ku
ZC9idWlsZHRlc3QueW1sCisrKyBiLy5naXRsYWItY2kuZC9idWlsZHRlc3QueW1sCkBAIC0zOTcs
NiArMzk3LDY0IEBAIGJ1aWxkLXVzZXItaGV4YWdvbjoKICAgICBDT05GSUdVUkVfQVJHUzogLS1k
aXNhYmxlLXRvb2xzIC0tZGlzYWJsZS1kb2NzIC0tZW5hYmxlLWRlYnVnLXRjZwogICAgIE1BS0Vf
Q0hFQ0tfQVJHUzogY2hlY2stdGNnCiAKK2J1aWxkLXVzZXItaGV4YWdvbi1ub2lkZWZwYXJzZXI6
CisgIGV4dGVuZHM6IC5uYXRpdmVfYnVpbGRfam9iX3RlbXBsYXRlCisgIG5lZWRzOgorICAgIC0g
am9iOiBoZXhhZ29uLWNyb3NzLWNvbnRhaW5lcgorICB2YXJpYWJsZXM6CisgICAgSU1BR0U6IGRl
Ymlhbi1oZXhhZ29uLWNyb3NzCisgICAgVEFSR0VUUzogaGV4YWdvbi1saW51eC11c2VyCisgICAg
Q09ORklHVVJFX0FSR1M6IC0tZGlzYWJsZS10b29scyAtLWRpc2FibGUtZG9jcyAtLWVuYWJsZS1k
ZWJ1Zy10Y2cKKyAgICAgIC0tZGlzYWJsZS1oZXhhZ29uLWlkZWYtcGFyc2VyCisgICAgTUFLRV9D
SEVDS19BUkdTOiBjaGVjay10Y2cKKworYnVpbGQtaGV4YWdvbi11YnNhbjoKKyAgZXh0ZW5kczoK
KyAgICAtIC5uYXRpdmVfYnVpbGRfam9iX3RlbXBsYXRlCisgICAgLSAubmF0aXZlX2J1aWxkX2Fy
dGlmYWN0X3RlbXBsYXRlCisgIG5lZWRzOgorICAgIC0gam9iOiBoZXhhZ29uLWNyb3NzLWNvbnRh
aW5lcgorICB2YXJpYWJsZXM6CisgICAgSU1BR0U6IGRlYmlhbi1oZXhhZ29uLWNyb3NzCisgICAg
VEFSR0VUUzogaGV4YWdvbi1saW51eC11c2VyIGhleGFnb24tc29mdG1tdQorICAgIENPTkZJR1VS
RV9BUkdTOiAtLWNjPWNsYW5nIC0tY3h4PWNsYW5nKysgLS1kaXNhYmxlLXRvb2xzIC0tZGlzYWJs
ZS1kb2NzCisgICAgICAtLWVuYWJsZS1kZWJ1Zy10Y2cgLS1lbmFibGUtdWJzYW4KKyAgICAgIC0t
ZXh0cmEtY2ZsYWdzPS1mbm8tc2FuaXRpemUtcmVjb3Zlcj11bmRlZmluZWQKKyAgICBNQUtFX0NI
RUNLX0FSR1M6IGNoZWNrLXRjZworCitmdW5jdGlvbmFsLWhleGFnb24tdWJzYW46CisgIGV4dGVu
ZHM6IC5mdW5jdGlvbmFsX3Rlc3Rfam9iX3RlbXBsYXRlCisgIG5lZWRzOgorICAgIC0gam9iOiBi
dWlsZC1oZXhhZ29uLXVic2FuCisgICAgICBhcnRpZmFjdHM6IHRydWUKKyAgdmFyaWFibGVzOgor
ICAgIElNQUdFOiBkZWJpYW4taGV4YWdvbi1jcm9zcworICAgIE1BS0VfQ0hFQ0tfQVJHUzogY2hl
Y2stZnVuY3Rpb25hbAorCitidWlsZC1oZXhhZ29uLWFzYW46CisgIGV4dGVuZHM6CisgICAgLSAu
bmF0aXZlX2J1aWxkX2pvYl90ZW1wbGF0ZQorICAgIC0gLm5hdGl2ZV9idWlsZF9hcnRpZmFjdF90
ZW1wbGF0ZQorICBuZWVkczoKKyAgICAtIGpvYjogaGV4YWdvbi1jcm9zcy1jb250YWluZXIKKyAg
dmFyaWFibGVzOgorICAgIElNQUdFOiBkZWJpYW4taGV4YWdvbi1jcm9zcworICAgIFRBUkdFVFM6
IGhleGFnb24tbGludXgtdXNlciBoZXhhZ29uLXNvZnRtbXUKKyAgICBDT05GSUdVUkVfQVJHUzog
LS1jYz1jbGFuZyAtLWN4eD1jbGFuZysrIC0tZGlzYWJsZS10b29scyAtLWRpc2FibGUtZG9jcwor
ICAgICAgLS1lbmFibGUtZGVidWctdGNnIC0tZW5hYmxlLWFzYW4KKyAgICBNQUtFX0NIRUNLX0FS
R1M6IGNoZWNrLXRjZworICAgIEFTQU5fT1BUSU9OUzogZGV0ZWN0X2xlYWtzPTAKKworZnVuY3Rp
b25hbC1oZXhhZ29uLWFzYW46CisgIGV4dGVuZHM6IC5mdW5jdGlvbmFsX3Rlc3Rfam9iX3RlbXBs
YXRlCisgIG5lZWRzOgorICAgIC0gam9iOiBidWlsZC1oZXhhZ29uLWFzYW4KKyAgICAgIGFydGlm
YWN0czogdHJ1ZQorICB2YXJpYWJsZXM6CisgICAgSU1BR0U6IGRlYmlhbi1oZXhhZ29uLWNyb3Nz
CisgICAgTUFLRV9DSEVDS19BUkdTOiBjaGVjay1mdW5jdGlvbmFsCisgICAgQVNBTl9PUFRJT05T
OiBkZXRlY3RfbGVha3M9MAorCiAjIEJ1aWxkIHRoZSBzb2Z0bW11IHRhcmdldHMgd2UgaGF2ZSBj
aGVjay10Y2cgdGVzdHMgYW5kIGNvbXBpbGVycyBpbgogIyBvdXIgb21uaWJ1cyBhbGwtdGVzdC1j
cm9zcyBjb250YWluZXIuIFRob3NlIHRhcmdldHMgdGhhdCBoYXZlbid0IGdvdAogIyBEZWJpYW4g
Y3Jvc3MgY29tcGlsZXIgc3VwcG9ydCBuZWVkIHRvIHVzZSBzcGVjaWFsIGNvbnRhaW5lcnMuCmRp
ZmYgLS1naXQgYS8uZ2l0bGFiLWNpLmQvcWVtdS1wcm9qZWN0LnltbCBiLy5naXRsYWItY2kuZC9x
ZW11LXByb2plY3QueW1sCmluZGV4IDcyZDAyYmM2NWJlLi5mZTYzOGJjNWZkNyAxMDA2NDQKLS0t
IGEvLmdpdGxhYi1jaS5kL3FlbXUtcHJvamVjdC55bWwKKysrIGIvLmdpdGxhYi1jaS5kL3FlbXUt
cHJvamVjdC55bWwKQEAgLTMsNiArMyw4IEBACiAKIHZhcmlhYmxlczoKICAgUlVOTkVSX1RBRzog
IiIKKyAgUUVNVV9DSTogIjIiCisgIFFFTVVfQ0lfRlVOQ1RJT05BTDogIjEiCiAKIGRlZmF1bHQ6
CiAgIHRhZ3M6Ci0tIAoyLjM0LjEKCg==

