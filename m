Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F667606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZMoXibdQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=THJG+cLU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQNOc-0003GT-Mt; Mon, 09 Nov 2026 06:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQNOY-0003Fq-Kx
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:18:41 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQNOW-0006Uv-9o
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:18:37 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9AukEx034371
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 11:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nbmvOTed+nuFjEIe1sXZXZBhOzbBziGzM8YDy+80OZ4=; b=ZMoXibdQEMPa/O7B
 P7q5ZF7l7yF2/kHD0ZAgR1gdLXR3husTush/oX/GUbFWzVUMiSbumgD4EGi3i2gf
 rx9zjJo3hWF2GKVwhBucwne2BkHw4N9Uw60A+eaXB+HiJRSEdkj7MkY4pu2T9yrP
 dekG3cH7xKNp8MRQdo+pslRD4dywwfHScsbJNcnRqP7kY/Mc2xHLEW4x2xu5DMBa
 d/L/XneN6wX6ObKQ1N2NGbpMh143punF7eVNqY1JGvYHqcCHVmay4zkGg+UF8Tdg
 JxRsbt9EzgNv47C4BVMV66nzYXJ0RFYaz0eMCw/6f6mp2DEeykuGR5WKr94LLZOS
 pwFDeQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5r384-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:18:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2373e9b4so72494785a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 03:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794223113; x=1794827913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nbmvOTed+nuFjEIe1sXZXZBhOzbBziGzM8YDy+80OZ4=;
 b=THJG+cLUBbGy832kOzbfGgt3woNIKAqxB/DYUueAReBito3f9VBdguWzgPO3oRxoTK
 iFVQ0XHYk05Hdd45PhrwSglH8YrtoYPLfJkiei4yHC/AQ1EDOv8XWYnIa+sJwEXQcVbC
 H/sBG39YChlqRVqdQ9onT9pHP9djLc8OJ18x3d48MJZfEr2kzzNx6QaLnr20/ncmBI8U
 rr7bN3XncceE/EK0mHG+Nc5VTA45KJ2tbCbkUdyhV5pF0D48y+lNshqoHqMrbdTbRCMK
 YPxfZt3SHV/fqc6neCAGzEAdva0Jl9VTfmOLqYw8dM+j/DMzMwFGvYwRndpdwXqBc5vA
 kdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794223113; x=1794827913;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nbmvOTed+nuFjEIe1sXZXZBhOzbBziGzM8YDy+80OZ4=;
 b=RNpkZhtxTkFBan9FJMZAyXtW9vaQ2SAgNyO/HC01eMC/GfznSIXQhq9k11M67kY3HL
 OpFLGm54Omw2WBxjwCgJrDQBTtK+ZIuzJXR8yzg371aEUEyyf/PwIlsE87eEX/KJUqqR
 koCgDIs8QAiinI4wGfCnBxDMaDiAGwwX/nUDcinpmRL/GXJA0Ry7q5EuQAWWlTXb0IDF
 IumTLIN3o1EBWJc5OjvIsLXFuWknWjo2DMivXGLPs4e5sZWa03JeCn6/SxSmeiyLzauZ
 6y6zAfQXNnHtKEkrQh8aNHqezy0hqZ1Va/v1ERhBk+JWxViPQtlwSL7qIXhGc1CTCgEp
 zi7g==
X-Forwarded-Encrypted: i=1;
 AL+hErHEsNtRBV4iD5Zq9luhJUDnx/BdA6Mv73UYdB+AORfEgBFmhFGBIbSFAa/KjTXVYCpHyO4Qr6ENHw+e@nongnu.org
X-Gm-Message-State: APuU4Z8veLyiUHeTENwbc/eQmqpFMSKdK+fFpq5WPOx42CX37vae0kzI
 Og991jltjUeUAeWQOX/dN91WfNm/0/Xft6uIMgHEvtd2J9pPvMLcDftVPy4L+8gtmd5H3AsUJpv
 a03MwzKzR71djeCLv7yEzBjT0Diq/+FXtXIefSN4PEjC8NgxUpFw3dOMstA==
X-Gm-Gg: AYBFou3H3u8Qgcj8xywYo0kXt6dforVpcs3mIBfkDgzVdlqPL+CsJw1Z2QUzR/fQDI6
 RenFdZ1t+Ki2D5yCENev9akxKDKsxa1X94cbiWrpsw/lLPu4bYMU9BCciCH7FafJLwvdC5IDOtI
 RAGbewOgq4zTj/SaLn/VMLX9qFHcyUm8DTPvldGuJUKdEU/KpjSw7NtJSqSRvR3ZLLra8AtRoJZ
 mhWZjlGvH2xnHAGSn5+FI2dD58NDKMkkoDF9GoBa9WmZga+6zP21d+3maSMcM4VOIHXU0jkDPMR
 vqsG3Ro+BKGPPpzk+e+rOTJntx4BBQP4v7f/Q1mt/bzwI+FzJ/VTNxcdBcMX4LuG6dYSQimIKTu
 VCSkvRAm5kv/8qBiaT1PkzWBBRSPXt6OXaZ7+m1wvjIlNA696b9qvy23AUiCY9ZBiIf1EsAWo3Q
 2tZZm+TA==
X-Received: by 2002:a05:620a:410e:b0:93a:824:ac8d with SMTP id
 af79cd13be357-947842019e3mr567964685a.27.1794223113150; 
 Mon, 09 Nov 2026 03:18:33 -0800 (PST)
X-Received: by 2002:a05:620a:410e:b0:93a:824:ac8d with SMTP id
 af79cd13be357-947842019e3mr567960685a.27.1794223112473; 
 Mon, 09 Nov 2026 03:18:32 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7e32b46a3sm241751695e9.6.2026.11.09.03.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 03:18:31 -0800 (PST)
Message-ID: <5b59c0d8-182e-42ab-a2ad-97938c45f40e@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 12:18:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] whpx: QEMU 11.2 pull request
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0NCBTYWx0ZWRfXyJbdsncIQgQV
 L9JEx/1ifqnMfSLpbiGzb2hEU3fA43u4Is5gpq0uEt7BMgGOx+GZT/u41gvH6yezanWuxk/PvLm
 LAGVyzGfM4k7mWw9EFIuCTeu7mgIjdU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0NCBTYWx0ZWRfX8U5Wy1OQHOJK
 yjI3nozRx5pOeLlakP5aA3ZzQH7wKVjvatg3KBmhaplmTAmWuHzOE/WgpW6iKk5rl8Y8gjUC3Z/
 +1bBwNSaXAiv85z+pZdA3tzJSmYjH+c9X7D2x8MHqs+diSSeUeNPCDREbe5xOMgk+RhRNAqNI2r
 iOzq8fhec0rBRaFtIXFY4GUtBrvtuwLT9H5pt/wgeifC5GhjwZOBW8xiWQFOonnaTxRU1gJDk5b
 kvLzDFedQUcm3JOFNpqQ+6u01GArSPhthy0a2LPkTlHFmAN0S31B6mSf6ShY+cSz3kKv4tSUGCT
 AZMo1qKgAk4PVdmPRDFaR+iW/wlPnX+fYuXnwTYehvNl5pUTNo/irks7HDBeMrN6u68RodamkbZ
 6popLEOgeuupey4Jzv5q743jVuAuiqyDkYDWJASLYQwq+bGMJE7iQJmoZZ8E+hryh64BL9Zv1/R
 9iFMrrlPPPYB93pOf2A==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af1ac0a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=6zyypkzi77a1KxKLW10A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: mYm8w0NmQWtAHVMdonfb7--55sFqI3ZH
X-Proofpoint-GUID: mYm8w0NmQWtAHVMdonfb7--55sFqI3ZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090044
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/11/26 01:40, Mohamed Mediouni wrote:
> The following changes since commit 71f25c75417d31c214ba2cd26b273c114fc99987:
> 
>    Merge tag 'pbouvier/pr/multi_target-20261106' of https://gitlab.com/p-b-o/qemu into staging (2026-11-06 12:28:21 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/mediouni-m/qemu tags/whpx-fix-0-pull-request
> 
> for you to fetch changes up to f1ea9f2e15236020aff70e37e56f3443c9203052:
> 
>    whpx: i386: also save debug registers (2026-11-08 17:39:41 -0700)
> 
> ----------------------------------------------------------------
> whpx: QEMU 11.2 pull request
> 
> This is a cut-down version of the "whpx: i386: updates for QEMU 11.2" patchset
> with fixes for QEMU 11.2.
> 
> These include:
> 
> - fixing reset
> - CPUID fixes (leaf 0xd)
> - handle systems where nested virt is advertised but not working
> - xsave fixes
> 
> v1 -> v2:
> - Adding Signed-off-by to all commits
> - Rewording
> 
> ----------------------------------------------------------------


> Mohamed Mediouni (6):
>    whpx: i386: get APIC state before VM save
>    whpx: i386: fix TPR encodings for local APIC
>    whpx: i386: save/restore xss
>    whpx: i386: make nested virtualisation init failure non-fatal
>    target/arm/whpx: handle processor reset
>    whpx: i386: also save debug registers
Some of these patches are not reviewed. If you look in the
history, un-reviewed commits are very rare. I'm glad we get
a WHPX maintainer, but being your first PR please take some
care with it, because that'd record a precedent and I'm not
sure other maintainers agree with this practice (I'm not
saying I'm against it, but as a community it should be
discussed up to reaching some consensus).

