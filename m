Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66A7606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cGHzmPRH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YohxT8xb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQNHJ-0001fr-FT; Mon, 09 Nov 2026 06:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQNHG-0001fF-Tt
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:11:06 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQNHD-0005us-GK
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:11:06 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A99umMp2502909
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 11:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QkR24FH/XzHBJI73IJswZnFvE+fcRrR4+KhNWuRcFDg=; b=cGHzmPRHPW2/t+eO
 n/lSB2fVC25cM1FjAOSm+s1KMOWNQ/uQjYVG+8J38I0/CGL1FvOHI1aAeqLXIqRM
 kN6b3Ix14VQ48XqbtzZMdecujx6KVSa8xk7Ag9qCfpr4mVCOhe/7Uz3J9SSOMgIS
 i2GzOAN16qq+DjXYdf0vz1BYs65YJ6DJayKigw26FluFXfzOyYmCu13i4hEplMl4
 glf0wQT6NeWESNeFIuFsId/XRs3kpn5qGy5v4b+yfSxYYYsg2d0yERWeMZ/r5Dt0
 WC1yjDqN+mn2yqJiIxZ+RjRNAotzKyKLZPSFu3nbtV+iYQC7hF4xekE2q1Xb+IkH
 GBEIog==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hubt8rapj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:11:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f5844cb60so139790485a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 03:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794222659; x=1794827459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QkR24FH/XzHBJI73IJswZnFvE+fcRrR4+KhNWuRcFDg=;
 b=YohxT8xbyH7pcJnGAOL4DZ5u8vQmagD0eSGqz7DLvlbr3ynjqeNxb4w0HjrQ1p4KBo
 yZPI8t9LeD2Nn7cLz4mhdlJc2FMBcF+JwEHQJUIl51C0ocBNoPeME3Tcn1igwxbQcT7V
 f1AFcgqnYd30cgWI/9q2wGxQf8IfQtLhEKsF2o8WzhwusG29u1wpuVUBzp2P1Zy1r0da
 0Z0hRwQmgGUeF9aBRyXHa6uyZLn5UeQcwv0xTGtb4GCVuGgp8SG9ueTLFOgBp47Sdemz
 4wAOJRuSeggqH8NnGqVVrdj4pX9Jl134JpybWv4nIhVYjyRJV9f3E1Cn2KPPEiLnyxPS
 3bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794222659; x=1794827459;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QkR24FH/XzHBJI73IJswZnFvE+fcRrR4+KhNWuRcFDg=;
 b=lK5IPAUNyyOn2kED7EEMERUSWMMVyoHBuuJvKPrgxei7+mm+rmjq1Reu7+zN1UFmKd
 YF1RFgGmm1/pXwNtvEWHR/eTY5QGNaUe6iitnh3QzNFwhR57jzT9o5qfOsDbCW+iHKc4
 xHsdpK0IakBFFfnHRDiPAcl+cCLLies8AMTaylaWUHM4MjwenZikY1uPOJLFaZA/+40U
 /T5o38aUqBp5sq4RpvI7HxpQpOgaI5vE8HTGZxR/X+E6+PYxgIDYcu/rMgZT+FTeFRoy
 rOstyLrJ6Q+HPAJZMIZdWiye9Icj1NR3oPK1P1zyrsXsha/APEKX4KOqDrXMIie18u/o
 W/3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEcsyESDsHLVZUztg49wYyvi//OhoOjxYwasAZJgzl2uIG5SDG16cOqmNJpdljL5cb2X/mBTmHG5wfs@nongnu.org
X-Gm-Message-State: APuU4Z/caH8UJg+i53r/324gOzxOFxougWJIpdp9ZhejckMoc/pajr9K
 5tVvX53x0PokCF+X2+mTVrUhVGAWq1K2/4BT2JzMJjgnverLg6s22CwoKwJaM6enJEFU9izBCy+
 j6rEIzrANeXlRrvvvK7wgaYnAWrOb5wAAqJmq8UJXKZ/16c44812rG5wmNg==
X-Gm-Gg: AYBFou3oWtQF/9Set5UtZJH9htYTpMEiA8WQGE1fDkimiG7txclZWV/W+kG+V8xf8oT
 mi0BvVn4ob3zMuPb8jDQ3+rQco5puwemqGXxH4+aSgVSIpCLAHb1GB1oturvuv8XK/oathLe3sf
 M5e9hmOJOr8Du1J+6cF0Y1aDFWs9caJP8dsketC7EIKx6/nzPwN4Iqdbjz9mqt1TGt6M61SY90g
 rKfOXNIBh/FSFuC3ughpaDsZkY47Q36UUapHRZMqRqmUirYs7hlCBBAvC570spb1WrwN9zcUDYz
 VCZeztDO+0QcNswjEhC10A2vn8FBGjA9CvqrcSC6CcvszOqHV82wQVlyP5ciDON+23fhjK6q9zt
 kBtRQ62vEwxmhQziV3LPa/rvVtLBVq/hUf8/4XOjU4kS666GyE8xP5WH6Hxs6M5kMedz/P7HKrj
 xROjX2fg==
X-Received: by 2002:a05:620a:4485:b0:93e:64ac:5dfd with SMTP id
 af79cd13be357-94604b8d236mr914615185a.3.1794222659173; 
 Mon, 09 Nov 2026 03:10:59 -0800 (PST)
X-Received: by 2002:a05:620a:4485:b0:93e:64ac:5dfd with SMTP id
 af79cd13be357-94604b8d236mr914611285a.3.1794222658655; 
 Mon, 09 Nov 2026 03:10:58 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90ee247e9sm139330765e9.6.2026.11.09.03.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 03:10:57 -0800 (PST)
Message-ID: <89801181-1c31-4327-9f78-8a6ac69e1a0a@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 12:10:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] whpx: QEMU 11.2 pull request
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0NCBTYWx0ZWRfX+JO4kC2Z3uoi
 wQw1m3C2dpr0Sj9vYGRsiC+8TPzW3FBNelNRC6DYsP/zyPG8S8Sli7KAYMhIBKPHFZJSrt5VkIX
 b56GnhzK8sSHuPAn9YE7lbQN14WjXoS7M19NU0sj1HkWh3038emN8lsfGfjKwL7TqswGpBPUo56
 OEf4o7yVmRFNpdalhHyRgcXpqfJp0sw2S6EvkshzZJSIMFQKlutw78u5tLIfya6L19QkUTbnPik
 kVYGivfxfOlIre3WvgxcsmYmJRjCVgUz6CLmRNhK60FhGif40U6ag4b+UBmzg50rAiJjbCWeVpC
 ux/GC/6PcWAybFzxCznV8Sd2VJJ64lSFl8SZoaXAPjgMXnLj00EpmISabEAxzImil+B/rjP7NYk
 ZtMunXi8cmNItqzFB+0kZ+GPn1tPNZvp3rlFg7qnQA6X4ued5P1cG62JXY7QvGnS6E+KquyNpLZ
 7q1ZfuUO1BvURtjJsuA==
X-Proofpoint-GUID: u7IIfxEeRtuxuI38U3zYlPo4urqYTCej
X-Proofpoint-ORIG-GUID: u7IIfxEeRtuxuI38U3zYlPo4urqYTCej
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0NCBTYWx0ZWRfXzBB4F3VWS46A
 8C3n/WYkpIsxuodvr8xDXuA4DoVG6IIZNTt19PLWCIJk+5Be/USk3NWw3BQzEMowuY2pYZG+wxI
 WHkyL9iUU8SPqAUcXBhE0zX9jrKHoD4=
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6af1aa44 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=6zyypkzi77a1KxKLW10A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090044
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
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

Between these '---' is what is committed in the repository.

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

This isn't really useful in history and can be described before the
'---' line.

Don't forget to run ./scripts/checkpatch.pl and CI testing before
sending your PR.

FYI b4 and git-publish are helpful maintainer tools.

> 
> ----------------------------------------------------------------


