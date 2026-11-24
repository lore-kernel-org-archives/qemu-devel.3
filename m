Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60046606A327
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M72X27OL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jNfMwXG3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnQC-0006cH-6y; Tue, 24 Nov 2026 05:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVnQA-0006c1-GO
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:06:42 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVnQ6-0005ev-SQ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:06:40 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8jBPl647161
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iL36O3P7/g6Xc2rbX0/JczwBbuSTNso8jsa8ClWOwpc=; b=M72X27OLexmxxzSu
 EjJtbVma4rG+l+NZiSrmCyi/8GyZ1VWiwRZunWR69Wee4tQWeQ/OkhJdbeYawKxV
 0ZHl0Yn7rmrLPBZb6ISBPzDLSYD0+6Sy4dLfHwKGbTcrH+I3DPH/DCMxN3NBiv3+
 JFlRjxtDRmEJHJ3a5AN7UYtM0LeUUeavoeZksnKF1MieOTUhWp+AeFINSnCeYuxY
 lmbjEhwAsB2Vfm9dtR2H0VCLJxN7g5cbZo1kdAriXOB/6X7NSI0vwF57UsfTYr8Z
 LSRNxga9lDYcIERspSvKtBvGMW/QNeoi2PuoGsug8zk0bVsOT/ruvpO2ao0rVvhn
 oKr7mg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvd24ah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:06:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f5844cb60so782774485a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795514796; x=1796119596; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iL36O3P7/g6Xc2rbX0/JczwBbuSTNso8jsa8ClWOwpc=;
 b=jNfMwXG3d4EXC3E0A62a0UCyA8EisYpX4Waar2x+/Yi82WUBFxYoB7iVAaPk7dbIP3
 nR+F8ZTmMsxN4bmlvFC9s4Kepa343mfVdiBlbbwyCCN9iGLWm2/KDXmHer55TeTwy/hD
 CHCIof5nA6dPNLAqdtJpA8Hk8CiwllZlhMLPii1hUYm5bZCTx9lTOw51O5Lrja9hSySX
 KkcCcyzwGcVbTkKaEBFJwkUkF0B46+mgv/QV8CYM73yl0BALadAn3DvKOaFOjqnnwHXA
 DWFm04VrSsw2Hdd2oJeQfX7QZlO9PX4tdX/4JGTv8HtXa8LE8ksdcOajR2xt7EAWfgBW
 vPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795514796; x=1796119596;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iL36O3P7/g6Xc2rbX0/JczwBbuSTNso8jsa8ClWOwpc=;
 b=LZxb2lobPNJLNgTmkqB8YpX7SAXm5zKkfdau9b6GUhKM18Rlu63popWxpciy49hfrw
 6CCLFaZ+AvU6nBszDaPApF0oGxAHiI2Dlt8mkPNN+6kfmnbz5HP+NSuFDNqWxrzcI4iO
 jlirRodtiFg+1j86PDbfI/bas+LPa25p9DcI9xBU7Vk6Jl0S8+1s37Q44lEL0U+9rujM
 NxCHlr0Wz1f9brOVF5FdPL31g9g4M4BA1z5x7xVDsBqUb4Jfw+o4Tby3l9GejiEjCZQg
 zDDhW7YdGBmY0rqfYt4TaJ8C7VQwFp1F/rmaQ0sISrtGaIW2DykUXGdBD9lSgXuYNXm+
 IBeQ==
X-Gm-Message-State: APuU4Z9SGBe9c9uBRE5nQAOot/1kqRTNgf4vmZ4dtwy2gKcBSz//Axa3
 rby3fyesZujbijSwiDgLx6gaiADlb6O2W0H2xY6QJkLsYx1yEL8mEw8/dgSFvd0Vreyp6Gli8Op
 qOtjze/PMEZSOLrEJ3wNn1grpRNsGYB9WfyN4SIqlO3fTBtEl8RxdwSLtqw==
X-Gm-Gg: AZFdTZeL8i0GTs3hwR1OQOaAJSGfyVk4Bcb4s5z0HBZ7PBlYq2ZDJYDnDAXEFgvmP5p
 6xHcsc1ziBrCGQ/t2zfr1o4zujD/IOe8tqr6wahEaNcnHNokHFUKX4Sqh/B/X4vfSm9lHHDvRlV
 R18a+LjpStGApNFlH06jiIOvXRwNCQVnnlVeR4aFkR2NJ2BOnXXnz1iMWh68fVQboP34WroussJ
 QzvOpDX9umkZDr8xmeV5EJWTHppDqzJN8tyoSd7q/doQ4EWRXqwfPTXlpj2jT/OBWb2kSFGCC/8
 PCLmRCoSw72R+VHWgmqRXdAAKPfHXncMuc2jXZEy92lJ5bbt42/AxxO4bqecdWLweE5gAZxSoR7
 n7vpxgpyrQ56FcVTLlH7b+jYci0G+dQKGHGogAL2Vo46/SC34rzh5vmPZWOpdmAPBWerqeTa/8w
 CM3QCd9H0=
X-Received: by 2002:a05:620a:1327:b0:93f:3193:ac09 with SMTP id
 af79cd13be357-949b35725c1mr2644245985a.15.1795514796321; 
 Tue, 24 Nov 2026 02:06:36 -0800 (PST)
X-Received: by 2002:a05:620a:1327:b0:93f:3193:ac09 with SMTP id
 af79cd13be357-949b35725c1mr2644241785a.15.1795514795802; 
 Tue, 24 Nov 2026 02:06:35 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf685asm26642975f8f.20.2026.11.24.02.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 02:06:35 -0800 (PST)
Message-ID: <1fc28def-9c77-45a8-99d4-c1de8dd2d477@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:06:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PReP] Maintainer status check for PReP machine
Content-Language: en-US
To: Markus Armbruster <armbru@pond.sub.org>,
 Utkarsh Verma <uverma@linux.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth
 <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, Chinmay Rath <rathc@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
References: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
 <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
 <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com>
 <87mrqyhb7l.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <87mrqyhb7l.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6b0561ad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=RiYqj5F-7hHx5dKWC2gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzOSBTYWx0ZWRfXzdc9mr50TirK
 0jmtIinkVeOpwWOk60o0Nj+1Gg94F2MkzgNbMXUQQ03gV6hsGxuh46YRK+cxcMbskRWajep9mLU
 wLAyAxx80bU2g2cB4mR1hZXCSLZgLs5s3lN0/7lC3z4YnwzRfyxgY0fDcU9FwKYei9siUukfRRx
 1FYx7Nff6EXy1imOBcy5/nFtySvqEL084q9em4yvXDEJJNmGWUAm0CpjnVjV8jCeclId2PhQ14F
 nJUUFd5BrVqoIRlRW9+Q6qHcUqTEZfRWQAj51ASa5p8gfYX8wyxRjYs6vboRqSbAEuNw9ua43le
 75P9ltesRiwvY3Zr9kpSm2mkP/4udS31stIjO8sf+GMqJw89ftlIsOsbnXce3c7MJp5gOvNUu/A
 gXqdRp3wXudaegr8JPbxHo4t55Cm+ogeIv910o6pZ8ki2QlNsNWtdoU2yDh4Eppem1G+vJbuIXS
 9nGfgMnz824/X/BY33g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzOSBTYWx0ZWRfX5zN00LLY6flH
 kxTsNJKNojDRzpvr8/FDa2YBdGrk03h+Ccs8/pOscWqPqUo36XexbSh9ZzxGE2JUAbF3GVtmVLp
 aaIIYoYbTPUhMWmc8yg8vd4+jCfSdjw=
X-Proofpoint-ORIG-GUID: S85qo7hJlMeh7nVRlO-j7MvWLB03J1KL
X-Proofpoint-GUID: S85qo7hJlMeh7nVRlO-j7MvWLB03J1KL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240039
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/26 09:42, Markus Armbruster wrote:
> Utkarsh Verma <uverma@linux.ibm.com> writes:
> 
>> Hi Philippe,
>>
>> On 11/23/26 11:02 PM, Philippe Mathieu-Daudé wrote:
>>> Hi Utkarsh,
>>> On 23/11/26 18:14, Utkarsh Verma wrote:
>>>> Hi Hervé,
>>>>
>>>> I wanted to check whether you are still interested in maintaining the PReP machine in QEMU.
>>>>
>>>> Your name is currently listed as the maintainer for PReP in the MAINTAINERS file. However, we haven't seen much recent maintenance activity for this subsystem, and I wanted to check whether you would like to continue in this role.
>>>>
>>>> If you are still interested, it would be great to have you continue as the maintainer. Alternatively, if you are no longer actively involved or would prefer to step down, please let us know.
>>>>
>>>> In the absence of a response, we are considering sending a small MAINTAINERS cleanup patch to remove your name from the entry and mark PReP as Orphan, so that the file accurately reflects its current maintenance status. This would not affect the PReP implementation or its functionality.
>>>>
>>>> Please let us know your preference.
>>>
>>> Are there any PReP patches pending review / left unattended?
>>>
>>> This machine works well enough, is tested; what is your issue with it?
>>
>> This is more about reflecting the correct status in MAINTAINERS file as the currently listed maintainer (Hervé) have been inactive for about 3 years, although the patches are getting reviewed by other community members.
>> It will be good to have someone listed in the MAINTAINERS entry for PReP who is active in the community or we should change the status to orphan, so that it encourages others to step up to maintain it.
> 
> I agree.

I'm probably missing the point here, I'd rather look to help maintaining
unmaintained / broken subsystems. Why care about a well working area and
ask the maintainer to step down? Why not ask the same to ARM / RISCV /
X86 maintainers? What is the underlying problem?
If the request to kick a maintainer out or demote a subystem were coming
from a very active contributor with authority in the subsystem, I'd
understand, but here Utkarsh ever made 2 commits, and recently enough
the first is less than 4 months ago:

$ git log --oneline --author=uverma@linux.ibm.com master
b4380be275b1 tests/qtest/nvme-test: fix NVMe struct field endianness
29387351e0d4 target/ppc: Move st{b, h, w, d, q}cx instructions to decodetree

If PReP is giving troubles to IBM, first start expanding its testing
coverage, try to fix its problems or ask for help, and if nobody cares
they maybe. At a minimum start with a MAINTAINERS patch demoting the
subsystem to 'Odd Fixes'. Dunno, this approach sounds rude to me, and
I'm not sure it "encourages others to step up". Co-maintainance has
never be an issue.

