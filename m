Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A915606A891
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AKgrfQfr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M6J59kah
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtsp-0008GK-R1; Fri, 13 Nov 2026 11:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtsj-0008BB-QR
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:06 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtsi-0007xB-6n
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:05 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFR5bH551933
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hJJ1ea/NZuyzPcoJiLozvu
 BD3bTy01LY3myrqP093CE=; b=AKgrfQfrPjGaBGVncGLfajQjpEaI5DtghKL6ys
 D7SV3amDPG3WKKlC8cjt/pUAuJHSAhKYWZVwkA5J7h8Q7QeVNiv4TdqJO/OvZOKJ
 /nQiv2VPv/E1se0IR8czvL10dSH3DCXjTFrvE6ychDvoF57XHs9Y7H2rZAQwYOmU
 tXNS9pCp991kAPz8ODcq6GkDt1IqehauXmOGi/SrNSPLhkXOoIZgfQzIaGTN95dg
 XxHUy2tdD09P5/OiwprXfRRo/YrvOrZsn16t/uZmc5+rfrcD1lkfeZCKgrcscKbI
 E7FHsH4ImsNJT+Pujb6tSL+Cm13qjoM78UXb/9X+jjs6+0DQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwbs8w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:02 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-99c3b473613so191841241.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586321; x=1795191121; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hJJ1ea/NZuyzPcoJiLozvuBD3bTy01LY3myrqP093CE=;
 b=M6J59kah3XEP7b59+0myCI+VRB0562UquySAJTAV5PJyVkQev+b/CmoM+/6Wen11hu
 ymOwrt6L4SzuuSM2X3QI8u9tbOQ2I6G/N7sMLDDOy+dEA4MIH9w/RoG4vMnfXkZgt2k8
 0Ji63IJrHbv7/aPZjXto6CC7E/AU4cKnh5ig/KvSeJrMjfU3crwKN2b23tzWcgEMOx6m
 5+cajQeZgxzv8l4UVa47e6FSWFyf+fxHCGVWlteualVJNE3BlQoe4RiSW4OzSt+LiSmS
 6HZ3qZxnUVXuB7tGEKUzwC/Ei7sFVOVSa3nMV/EQh/9+WBxaXEmrXb7iNmGEmgV0NgBK
 6Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586321; x=1795191121;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hJJ1ea/NZuyzPcoJiLozvuBD3bTy01LY3myrqP093CE=;
 b=PGIIBPMLBR4gr3ed7x+RxYUXiDpOsTOhJsguoMdofMT1qZY4cZbLu404K/XezVi+a1
 9zIJaxkQafQnq35yhCIYpD/OyLSshyAjagmHG9uBaKRlVFAs4tnXlj3CyXn5/oz1tTZD
 RfyHeYzL7EqGMk//LfV0XhoLrlJChvZEo9fiqJR0MiH16jJ5JvsMGzuNga76r2rLQLqr
 tMmfQefjRTs20GM/LgVsCzIdM0OGvV8eMLSxZxFRg+j7LXv9smOJho6tmhCff8bxl8wX
 LWXQpGMlbx7N413eOPvccN8iPKj1h0uUxr5YGpVewRMKTq8PeCjrSFb6lBzDbFd21/Ij
 63WA==
X-Gm-Message-State: APuU4Z/i73/ilNWqRGjB14DnvpLaV4555wU3uqQBzvPkgD/bG3RM9wp1
 O8Yl2AGsSQ+AEJW+p7dYjBSSg1LdQU5og5kB6pj5M4lYQ9RNxbNKriRCHDPxlWAEzZU5p6tZbHh
 5j4A+f8Et2qe6uPTs290nkaXkvIbG1Xa2Pt4IAhNS5lZ85Nkb4D9lAFQGBLc0V1KOhWD+
X-Gm-Gg: AYBFou0aL1ieFyTC9MQr9DyWsMaurIwYjrW0FLRL56/yFjb96qrUeVETY5f4GSidm1o
 EjvkpVOhoHJgwxlIKXuushVS8NuNTU5s/OiHtnRIpGCDISv/jFqdXjbzuWmQijmc3DD4LO0GAaK
 r7U/AaivpplcUa7Phl6wZvJHbpGa7ZUTPvSCtPtYXGEvTwdaJFsDPpESRPg8Ds6QJAjhgTRDH/+
 0TOoTXsGtFIe5qv4hlkhp/AsaGwk3aZ12+c3jOEDM1nI1QZFKNP82cddd+QX3PGs1HZDii5wEob
 5cZChcMSeO1hoXMZJFz7YuWo0aAsDNomM5JiqRt9JFCKfB/2d6yUT995N0P2SlpFSlzM2BTKzEH
 y5paCGdwPUfgVSWKzKlfQnt92dAcFHEPnkkqvMNhQPJEy9Zac1vh9XpPMw+VGIzmvQRilBDuY47
 UAWZDF8311iVM7xA==
X-Received: by 2002:a05:6122:3305:b0:5ea:b1f5:a657 with SMTP id
 71dfb90a1353d-5ee34a4584bmr929400e0c.7.1794586321555; 
 Fri, 13 Nov 2026 08:12:01 -0800 (PST)
X-Received: by 2002:a05:6122:3305:b0:5ea:b1f5:a657 with SMTP id
 71dfb90a1353d-5ee34a4584bmr929368e0c.7.1794586320971; 
 Fri, 13 Nov 2026 08:12:00 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c1797sm6731410f8f.11.2026.11.13.08.11.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:12:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 00/19] target/mips: Mixed bag of fixes
Date: Fri, 13 Nov 2026 17:11:38 +0100
Message-ID: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af736d2 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=tkKFcgofZQh0W6jyqBsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: UjKdNziI-gMXoFhvliFdr9i2X72cg4sd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfXxgdDUXxLiNsw
 kC7V/OAWzNGA/yJNPjnXlASL18NgJjXFJiIXB7cWGROYVcKC4m12O7VS3XNIpJfe4+VBSbAIfuS
 DUHZoX0TPeC7260bEJN86hz493ZRhfTZ/bP1+7f+h2fyNe5FmVl2Z6Ei5nkapPPwrApCFbuf+ue
 3YSg4OTrWpQmmluFTsjZxzD0+RjOAxFHoW1lxVtLGMjbVuh3RmRc9WeUbUkUamatY8bUHrx+Hi9
 ZCKVRvGlgMyGBFr1YCyt8oH+e3Kmm8DGG9sDWniuzDkCPnfztY3IAfZh2OSWD8L4r+ib2Z6PUbN
 229LAlYhvp3U8TE2ZGV4gVEPUWgCCfk8HB0Kk2KmeNUqXSFvd2CT5o76r67N1BT3IW5KoYq+X8h
 ie0iC01l6T2LDKMznNDSFTDfiGDRRNrPM3EoLePIypvJ22BcK3XbMutQDRUkRwhTEAf5oxJx8ud
 D4zyIS4OuduYhsMi/8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX5mMxNI2YbNou
 FqIoi10JVX3D+xTiXJLG7fw/GzjatLgRqNj6Y8lljxf98ZhqUgBfft4dWE/9UTBbiLwWym4ItG/
 ZxJvi81GGjzlGltzckys32Z/mmDYMxA=
X-Proofpoint-GUID: UjKdNziI-gMXoFhvliFdr9i2X72cg4sd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130064
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Various individual fixes noted while reviewing manuals
during decodetree conversion, and using a RISU prototype.

Philippe Mathieu-Daudé (19):
  target/mips: Check for MIPS II when decoding BLEZL/BGTZL
  target/mips: Require rt == 0 when decoding BLEZL/BGTZL
  target/mips: Require the MT module for MFTR/MTTR
  target/mips: Reject the PMON encoding on Release 6
  target/mips: Enforce alignment and 64-bit CPU for the DSP LX loads
  target/mips: Fix reset into microMIPS mode when Config3.ISA is 3
  target/mips: Fix microMIPS BC2NEZC POOL32I minor opcode
  target/mips: Fix microMIPS CACHE offset used for ITC tag access
  target/mips: Add the NMS check to the nanoMIPS CACHE instruction
  target/mips: Fix nanoMIPS BPOSGE32C branch offset sign extension
  target/mips: Pass the right instruction size for nanoMIPS RESTORE.JRC
  target/mips: Fix nanoMIPS BC1EQZC/BC1NEZC always raising RI
  target/mips: Fix nanoMIPS BEQC16/BNEC16 corner cases
  target/mips: Fix nanoMIPS BLTUC with rs == $zero
  target/mips: Pass the nanoMIPS BREAK code to
    generate_exception_break()
  target/mips: Decode 6-bit bit number of nanoMIPS BBEQZC/BBNEZC
  target/mips: Don't set forbidden slot on never-taken nanoMIPS branches
  target/mips: Do not sign-extend partial LWR results on Octeon
  target/mips: Do not negate NaN results in NMADD.fmt and NMSUB.fmt

 target/mips/cpu.c                         |  2 +-
 target/mips/tcg/fpu_helper.c              | 39 ++++++++---
 target/mips/tcg/translate.c               | 39 +++++++++--
 target/mips/tcg/micromips_translate.c.inc |  4 +-
 target/mips/tcg/nanomips_translate.c.inc  | 81 +++++++----------------
 5 files changed, 90 insertions(+), 75 deletions(-)

-- 
2.55.0


