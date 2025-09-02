Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54834CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI4e-0003tA-M8; Mon, 01 Sep 2025 23:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI4c-0003fB-VS
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:52:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI4a-0005EX-TS
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:52:46 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RmA8012351
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kkxhfkaxtD/ScgEEmhVJ97g2A+n86srGHtAmCD7hC7c=; b=Sgc7RqernF0FphAe
 Q+/vIWrx7LJIj8Nz0QmUqj+aQ1tOa0RJLs9sfTE4RagmWeNgKMAOlCajZI4r5nyf
 Ieu/bZvXVUn69s9skORKaw0C5IBE+sKmZ18XS97P9V8HgDeuV0+7czzKOhzZ4TfB
 UHUzz2L7BXZz6+mf0EZLNcCy3a7SKWeP1tqpLBoDZexWGSNZaNfK7O4CtACRG/X3
 ubISFc3ROQIZr0BiyQKyRW7FXwx0irPQ3nQOqBFR21olLwPadPxdtnUqbEvGSIKU
 bxBHm7gUJno+jqvw/AMSSXt3lTOdszUhMDp+u3XovtCbKDjPCV1bdRIXBrPRZvT+
 G23ZqQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2feadt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:52:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b47174c667aso3866547a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785162; x=1757389962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kkxhfkaxtD/ScgEEmhVJ97g2A+n86srGHtAmCD7hC7c=;
 b=Swg85KjJ6CsETj0jmaaohCWFgQiMg1P8BLbPouDj7q3rp/Wg6YLmxaksFKqiteYD8m
 mlBxksYjKkWkPcCYrcGC+JgJswc8rXER3AAa+/+/d80GYot6Z67l71nm8/uiNWsdUmeU
 RVPUIDvxjGoiokJn7NZVhzKifjKEnTNdp9JgqscBHQPoRWh734JrrFWTMOcMRp5Ks2qW
 n3Y8BT5e4WtagF0ghvI4LxZqizZzdhhJxazcvkya5hApYuY+DKNNN9nIrTbjvp/1RzMK
 JGg1mvU1Fl8V6adT85sqBOuy2z1sIwkzFfft6SZbUE5hKPeC5hH0tALlU7E/o5kpTzDF
 zRYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFxikhP9Flt+pPCeABDOI3jtKZp+Ge4+fDlLaPkSRcPlry2VCsnlILS0jeqmjsX4h4Vt+n8QLTPkjG@nongnu.org
X-Gm-Message-State: AOJu0YwZVBTiiSl+9Uv4ZhEoUdxro81R0pX/GGjf9nuJ+/tRetz3vYZG
 ahcVbjR6rYvOq+iBX/ftlyLq1WAS4wnSr2kIVysEVfGtFmgk+rQxmy14C44EVbRNwneNpVEwYJi
 FLgsOp72XpKVO8OvcdCW7O075+ph60D1oLMBapJRi5+zwTR1fLq9f9iXZJw==
X-Gm-Gg: ASbGnctPlMcR7Bh3zmBxAYNw+R6Hxkqr3F0HrJnIA606vFs+7bJawEIe1V5lWRiemlR
 jiCo9SFyL/a8/vbjGU6Ql8dqkVrqMpYmy3ZoC6Pz367d68IJR3WmrjyiuHunP29m3PbzA8wxfPQ
 S+90NCmZ2qvBaxyLtqzXGW4Tda3UsUUfjdzpPaIMnrAyHGo/+TsbZuqkUsPT6+Kx9KYYvDDHXq0
 /++Z+VHv9JR3C8vJl2SgZI74TPcRgY4ThR4KCSLA1oRfn6sDM3so3/lATfKBc3OIWz4oXvalWr0
 M4WJAvw4rR5tSMZWP2tcSiOMflGCSHle/Ut4DK6S3J/OMNFWDEjKSgqGSBth/w==
X-Received: by 2002:a17:902:dad2:b0:246:a532:3343 with SMTP id
 d9443c01a7336-249448f897dmr108326545ad.10.1756785162106; 
 Mon, 01 Sep 2025 20:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ3gEGbzjQERZxddhHTiHnFk3HcbYbMW5KQzlH1QToNYepLr/w2u7LoBCQA8VKzbSaC6dTCQ==
X-Received: by 2002:a17:902:dad2:b0:246:a532:3343 with SMTP id
 d9443c01a7336-249448f897dmr108326305ad.10.1756785161588; 
 Mon, 01 Sep 2025 20:52:41 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119295495ad.45.2025.09.01.20.52.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:52:41 -0700 (PDT)
Message-ID: <151ff720-7319-4355-8bfe-57fcd4804948@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:36:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/38] target/hexagon: Add imported macro, attr defs for
 sysemu
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-13-brian.cain@oss.qualcomm.com>
 <028c01db8f93$4ebc2840$ec3478c0$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <028c01db8f93$4ebc2840$ec3478c0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX9wFqJu2dUT+n
 PYRwl7pAyAegVfIOKvPlK+0JuJGp4hMEwyLG9lNQ9TpwjyVqxVTPMvl499Wm6uadix4vx1Tl5oU
 44GFc6uLyUEIh7bPZagjgyHFB16gkl/R5sHJ4PyDfNjurvFHUMJxP0UYvgy0+UdeeO/dwnzNNyf
 C1eJpALWf+o21BhculFhhI67/Cx3DwoHGEw9qJaeaAz657VNnHuQ8MSnl0hMLRl2k2P+5DFzpuN
 eFHCg9i2igHnIbQP7e/qRL9FlUZ/2U8zsBhoZnEawlbFzqAC8pdO9IWYOwE+TPFeSe0JLvmDeRR
 HrO+FfMvmBwlUwJk2Xy1nK3L3ghXa+cOOlh7/Dqt6Lhv51PygYc82KqPCHoDwsYlgSei9ibOwJX
 Y3gkbjZh
X-Proofpoint-ORIG-GUID: zWmUdgsshWHQXzeWTvG-ebc0mG2e7TDh
X-Proofpoint-GUID: zWmUdgsshWHQXzeWTvG-ebc0mG2e7TDh
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b66a0b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=MaOE8p6atZa1j6wH454A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/7/2025 1:01 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:26 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 12/38] target/hexagon: Add imported macro, attr defs for
>> sysemu
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/attribs_def.h.inc   | 414 +++++++++++++++++++--
>>   target/hexagon/imported/macros.def | 558
>> +++++++++++++++++++++++++++++
>>   2 files changed, 942 insertions(+), 30 deletions(-)  mode change 100755 =>
>> 100644 target/hexagon/imported/macros.def
>>
>> diff --git a/target/hexagon/attribs_def.h.inc
>> b/target/hexagon/attribs_def.h.inc
>> index 9e3a05f882..e6523a739b 100644
>> --- a/target/hexagon/attribs_def.h.inc
>> +++ b/target/hexagon/attribs_def.h.inc
>> @@ -19,20 +19,41 @@
>>   DEF_ATTRIB(AA_DUMMY, "Dummy Zeroth Attribute", "", "")
>>
>>   /* Misc */
>> +DEF_ATTRIB(FAKEINSN, "Not a real instruction", "", "")
>> +DEF_ATTRIB(MAPPING, "Not real -- asm mapped", "", "")
>> +DEF_ATTRIB(CONDMAPPING, "Not real -- mapped based on values", "", "")
>>   DEF_ATTRIB(EXTENSION, "Extension instruction", "", "")
>> +DEF_ATTRIB(SHARED_EXTENSION, "Shared extension instruction", "", "")
>> +DEF_ATTRIB(CABAC,
>> +           "Cabac Instruction. Used in conjuction with QDSP6_CABAC_PRESENT",
>> "",
>> +           "")
>> +DEF_ATTRIB(EXPERIMENTAL, "This may not work correctly not supported by
>> RTL.",
>> +           "", "")
> Personally, I don't think we should be adding all of these.  Few are needed, and we run the risk of having attributes that aren’t used in QEMU and therefore aren’t properly implemented in QEMU.  Somewhere down the road, an instruction or macro could show up in the imported directory with such an attribute, and it will cause unnecessary headaches.  Examples above are CONDMAPPING and EXPERIMENTAL.  These should be included in hex_common.tag_ignore.
>
> Better to wait until an instruction in a future version of Hexagon shows up that uses an attribute.  These will be few, so it will be simpler to examine each new attribute to ensure it is properly implemented in QEMU.
>
>>   /* access to implicit registers */
>>   DEF_ATTRIB(IMPLICIT_WRITES_LR, "Writes the link register", "", "UREG.LR")
>> +DEF_ATTRIB(IMPLICIT_READS_LR, "Reads the link register", "UREG.LR", "")
>> +DEF_ATTRIB(IMPLICIT_READS_LC0, "Reads loop count for loop 0",
>> +"UREG.LC0", "") DEF_ATTRIB(IMPLICIT_READS_LC1, "Reads loop count for
>> +loop 1", "UREG.LC1", "") DEF_ATTRIB(IMPLICIT_READS_SA0, "Reads start
>> +address for loop 0", "UREG.SA0", "") DEF_ATTRIB(IMPLICIT_READS_SA1,
>> +"Reads start address for loop 1", "UREG.SA1", "")
>> +DEF_ATTRIB(IMPLICIT_WRITES_PC, "Writes the program counter", "",
>> +"UREG.PC") DEF_ATTRIB(IMPLICIT_READS_PC, "Reads the program
>> counter",
>> +"UREG.PC", "")
>>   DEF_ATTRIB(IMPLICIT_WRITES_SP, "Writes the stack pointer", "",
>> "UREG.SP")
>> +DEF_ATTRIB(IMPLICIT_READS_SP, "Reads the stack pointer", "UREG.SP",
>> "")
>>   DEF_ATTRIB(IMPLICIT_WRITES_FP, "Writes the frame pointer", "",
>> "UREG.FP")
>> +DEF_ATTRIB(IMPLICIT_READS_FP, "Reads the frame pointer", "UREG.FP",
>> "")
>> +DEF_ATTRIB(IMPLICIT_WRITES_GP, "Writes the GP register", "",
>> "UREG.GP")
>> +DEF_ATTRIB(IMPLICIT_READS_GP, "Reads the GP register", "UREG.GP", "")
>>   DEF_ATTRIB(IMPLICIT_WRITES_LC0, "Writes loop count for loop 0", "",
>> "UREG.LC0")  DEF_ATTRIB(IMPLICIT_WRITES_LC1, "Writes loop count for
>> loop 1", "", "UREG.LC1")  DEF_ATTRIB(IMPLICIT_WRITES_SA0, "Writes start
>> addr for loop 0", "", "UREG.SA0")  DEF_ATTRIB(IMPLICIT_WRITES_SA1,
>> "Writes start addr for loop 1", "", "UREG.SA1")
>> +DEF_ATTRIB(IMPLICIT_WRITES_R00, "Writes Register 0", "", "UREG.R00")
> The IMPLICIT_READS_* and IMPLICIT_WRITES_* are examples that would need to be handled properly if ever used.  Look at IMPLICIT_*_P0 to see how they are used in translate.c::analyze_packet.  Imagine a day in the future when an instruction gets imported with IMPLICIT_WRITES_R00 attribute.  When that instruction is in a packet with an instruction that reads R0, analyze_packet will not know there is a conflict and decide it's OK to short-circuit the packet semantics.  That bug would go unnoticed for a long time and only show up when a large program runs incorrectly on QEMU.

Our verification strategy includes using a tool to generate random 
packets and execute those under a debugger. comparing the register, 
memory state with hexagon-sim -- like risu does IIRC. This means that 
bugs like this are much easier to find (as long as they result in a 
change to architectural state visible from the gdbstub).  This tool 
isn't public yet but should be within ~weeks/months.


Nevertheless, I think it's worth considering this advice so I'll explore 
addressing this for v3.


> Thanks,
> Taylor
>
>

