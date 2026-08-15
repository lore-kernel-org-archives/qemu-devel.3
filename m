Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F69C5DF6A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 13:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvEnl-0003U4-LZ; Sat, 15 Aug 2026 09:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEnV-0003QJ-QZ
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 09:51:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEnT-0002Qq-Tb
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 09:51:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDMdaV642797
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3/wpPupeOygP/pweg07xo9KePgPuraru2Nf1ElqVvVE=; b=i3qQUmG20NQy4er8
 cJ5wTn2n4QJd9OIUorGVDDufr+DAlBuSOS2kJ0U3ugaNlQTW1qus7BD6pyHV9aYO
 wwwDrWj+0bVZspUTuXCWZwDH+69otiCobGpj/TI+U0xlOBr3eXo3dBwEdxca5C/k
 jRZsuLnMjBhg2dEYqB+Lx8QVnLjPXEI4slfGQicmsqr9AamZUQNTW9pSglMgKIDR
 v9mk0AHEUX/pwef0KOfQ7JuRQ6vMSU9ye/fh9NMQ0inbPpdBayhOfq24gsRf6Xmn
 5Jt2aaD2fP3WsON03S7CCYr52XFL0zVFr5NYEuVgXJQQOnL3X9gxTgXus0XEDWq1
 CQyhhw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfs1et-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:51:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e695a3b28so309726885a.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786801896; x=1787406696; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3/wpPupeOygP/pweg07xo9KePgPuraru2Nf1ElqVvVE=;
 b=Ewo377MQAX14OmwXIVO/+ct23tudIjPrZMxL30S+ErF0k/7UV7+YxIQlewtyDNpYlz
 C0qZY9cMnFjzucSNC1MVOLnuuEb2pOntSwsbZLqkk3ruKJh+AOhqEUgf5nJlpLg2puzn
 djurcG7yQsflVfwAreA1R6QsxJ49Y4uqTdmy+ukMshGeYITrPSbMtjo3BckMexxOUZxl
 Ki148uYaYYbcORN7UCWVmioP3lS8+D4swgpEI9DE8aQboRwnhcxvCiZ9DLik8Aro4tU2
 J6p1leou+KASOces2GSVRetirlPNa12eBw0TfCx4EWVo4TLMtVFonKOSDvA1QUcVAafb
 6DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786801896; x=1787406696;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3/wpPupeOygP/pweg07xo9KePgPuraru2Nf1ElqVvVE=;
 b=sOfGdAh+3vXOcayQn3Aj/nj3TzTAz0tPr3O5+u9/k353pcOIk+gS0fzmU1xbJQAEiq
 595lYZEyj/eHD/YKHTe8j2P6e+402ouUuzDurG0q/ijPaHSXSURiW5b7BIpUrofaE8vT
 VZoSRbQY4np7eI9xbS4jjtROHtIjnaWYx9oX6Orjy7gnWhvhTb3ZNTJ7mchwnhd34EXS
 n3BGXa+vWvbi8MYeUwg5T3u85ZDZuLc5JKt+AR5oAHnhcxQxmWrlE04p5irv+INKf7Q1
 yfgPhvQ1TLOFsl75aLaeBWt0Q16UHvE0AW8VLWF1O23mrQvlqSi+bakuSWL6gVaDduly
 Kkag==
X-Forwarded-Encrypted: i=1;
 AHgh+RpAsP0K/p+ARfz0mwuo7jRm6IhaFVUC6zFLTHsj+RMgclbhbEwYP1lqwzyFBXsaPN8w81GBLDIIKzPv@nongnu.org
X-Gm-Message-State: AOJu0YzxGJUeJ6RAkOoOoMVPiMkVDDCwAT+KgLTquZkuvpCYb32/W6xD
 biFiX9fn7sDaU/TDnUg9WtS8V4083+rr0leDLwzdnTZW4zAOgUkY4MgpHnDWz2iyRJG3cB5jqQV
 JPEF33+oknqDwgO9GQMFBtoy6LUMmGwSwiktYQ2wkIB9KK4YqhmcADguWQQ==
X-Gm-Gg: AR+sD10y5h58u9diI1E6Q0OumjHsZvAP/nN/yp16zp3QgH1FQZYuJ6IicAb7PWuAH6P
 aW8QydIDktb2zKuDjP5In7emhtXJN8ApTyiiKvEH2AoA30pyUTDUs0X0DCnwMwVAKsWDIVQRt6J
 cp/ncOriNH6eCGq43dfN4GWgrOsZh6ZHwrndQJG90B01ZVZ0+Lz8xUvj8euzZZNuhaznn+xkHKa
 H1gEsIZ5xvN+qF1nkxyYfgHs1CnLZJ60cRFlPW2NflQShGpa1LoZy0kSG57XVzYaRBSg2lKO6aT
 Xpe4LfSyVcURkrVDiqYAkBqCfm5ArJp/+tbuvfCQqBRQTsXeUAAD6PNFiK6nK/FHZ4aryU8GCAb
 e+FZyd3OQoFmqrorrCmD8zy3hBAU9Y6QEYhQ=
X-Received: by 2002:a05:620a:7018:b0:930:bd6c:9c32 with SMTP id
 af79cd13be357-936c072234amr2031961185a.12.1786801896390; 
 Sat, 15 Aug 2026 06:51:36 -0700 (PDT)
X-Received: by 2002:a05:620a:7018:b0:930:bd6c:9c32 with SMTP id
 af79cd13be357-936c072234amr2031957285a.12.1786801895957; 
 Sat, 15 Aug 2026 06:51:35 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d8f4sm145587855e9.11.2026.08.15.06.51.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 06:51:34 -0700 (PDT)
Message-ID: <97c83c11-cac5-4233-a287-e902f33c2f01@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 15:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/elf_ops: defend against weird elf headers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260812081405.3811787-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812081405.3811787-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMCBTYWx0ZWRfX9teQ7AgHwGAP
 ZMJjDa518MlFdDIF1ZMqD5b3D89WHd7r3nTyZ9mlxqcTn//pQf6DO+cBHNDG25rIfrhjqH2Phjh
 llcdhplfsXSHOVWtWM6T1BwEhcfzalk=
X-Proofpoint-ORIG-GUID: g35SRRetJjD-qgDWI9s_akLZRSTafz1L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMCBTYWx0ZWRfX6I1xXCEET9FY
 xXdCAV1IBT5EUZJVPPwETZO4z4qdOIfoqI1hopKGbmz2WUFTSGyZZTm2gHAt6W2p9LpvEug5pdU
 qIU4li/cFGXPtdpECw8GCFyu8LDOjhpt4t2ytf0vT20TbnJDQkLYU0EKloCVKdw5A50UGYSB83R
 NZn4DLI/G9dPmse63ysTIBOjo+lxRz+OGq22Tc2JDyAdKYVRQaNgBQLWL3djPDKGEwqtasYpM7Z
 wdpC4d4Y9js1IdpeeBKtjggA6o7vjlL8TdJqgQfPKsE8nFybU93qXJTA5xQRvacBRzYLhh7U9kA
 v/BJrNg30gmaGMGPhzkFHPlxrniUe9fY40C/ySu0RBI9seSdooIfsd1gfasPt7m24KHR2n26sGp
 VNOERoWccUR2m3yy8OmnD4E95eE+ZSMVRJgFcem6rzHRZFZIX3XuG1aiKeX6C5qF6VKDyHjEa+8
 cXHPKGl5sy4NFxbexig==
X-Authority-Analysis: v=2.4 cv=TMJ1jVla c=1 sm=1 tr=0 ts=6a806ee9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=0PyytNiBVvIY1FerobkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: g35SRRetJjD-qgDWI9s_akLZRSTafz1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608150100
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/8/26 10:14, Alex BennÃ©e wrote:
> According to the ELF spec:
> 
>    PT_LOAD
> 
>    The array element specifies a loadable segment, described by
>    p_filesz and p_memsz. The bytes from the file are mapped to the
>    beginning of the memory segment. If the segment's memory
>    size (p_memsz) is larger than the file size (p_filesz), the
>    ``extra'' bytes are defined to hold the value 0 and to follow the
>    segment's initialized area. The file size may not be larger than the
>    memory size. Loadable segment entries in the program header table
>    appear in ascending order, sorted on the p_vaddr member.
> 
> which implies while both p_filesz and p_memsz can be zero we should
> never see a case where p_filesz is greater than the in memory size.
> Indeed it has been reported such a hand crafted ELF can blow up, for
> example during rom_reset():
> 
>    address_space_set(rom->as, rom->addr + rom->datasize, 0,
>                      rom->romsize - rom->datasize,
>                      MEMTXATTRS_UNSPECIFIED);
> 
> which could trigger and underflow leaving QEMU slowly filling a very
> large buffer.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4056
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> 
> ---
> v2
>    - ret = ELF_LOAD_TOO_BIG
>    - tweak subject
> ---
>   include/hw/elf_ops.h.inc | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

and queued via hw-misc tree, thanks.

