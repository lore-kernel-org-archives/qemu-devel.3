Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2625EC531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvw9-0003TW-NK; Thu, 23 Jul 2026 12:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmvw3-0003PB-6C
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:06:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmvw0-0007Nr-0D
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:06:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NF9Nu6162109
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 16:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7etjDyNUcjho5Z9i5TV5RUKQPZqHBwzJskbPD7GFUu4=; b=TnM2OG0VjVqJEd5s
 /NM4+iNenAtsNlBWviQru9ZpeaLmpUcAmSnJg9tVA23J0CzfLZhOXy1YKhqdZDAq
 zm3Xh+OGXTJmCGFpR356V6dxreEJUMcPXTEpbSXgrjeFcZduUgKlUX5UMeagRGX/
 zIptHp/v/Qb6Q7kg5LaMq+43NxiS6RFBdUAtQn1ghhcGr27A42x7pScflus5mQ8K
 GE7P7RBC1296mZS4i/2SjzwnVI0jfrZaOLeF23cCaGx71XCWp7O1iuTllc9KFsRX
 lYj9cXTZtXkAA0kKqT7+uLEfWDMF35OKRbis1A+i+YbTWq8EHvK17ToiOv3DJdZ7
 wPLqUA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fknbmgcek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 16:06:05 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-74ab744f2c2so219119137.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 09:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784822765; x=1785427565; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7etjDyNUcjho5Z9i5TV5RUKQPZqHBwzJskbPD7GFUu4=;
 b=iQ4t3smOHyVSZ50C3YiqjOCCFIHVGS56/4mmRt4uTeS/mSifflBCGIgpRm8wX6TC4P
 wMYVHGXH8X02eM63UoRkSXU/MP/U6HLDHsnBWiAwTFSIxnoDL6kbt4PjJlcW+PVJF5Wz
 iPTANzmIvKCOU9Wlj42XRkAf1Ke2rI9/7szoyZn6lcrR94NbofJaHrLESHO/NFY9H3+g
 Qa0kRgKA7X1je/wtflzuoNfAcqTmeSlpMyXOW9bSjqYake3dl1h6Y+6kQMbXb2iUCQMa
 9BjtT/szEoD0mRGU5CX22pq6L44m/yy15+gaG+Au0RtY3YsCTBbFH2HWMmJ3bLpe3QcI
 2RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784822765; x=1785427565;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7etjDyNUcjho5Z9i5TV5RUKQPZqHBwzJskbPD7GFUu4=;
 b=KHuN50fHDxFfvn3s6bgxtn0CrOqbyzOtPOusYdKgA2nbxEOfoxQj1q6ZpJPvsXgzfE
 q+LhNHmqU+wZQbYnt+3J/y68fkYqsYT4vBJ4Cf4D/KKMIEXZw8zH/WIPJhpEHaWIZKzf
 Io18ktzyhmEvAQ4GD8j4ITD2975DROFr8yOvy1GEw/KAnDHqGohsE/OXJYXyCseA/zu0
 y/C6rzCtwoA58tjxSmjarcwz5fbPo+UWs5EyqefhTPOn0QqyXTmP8GQjRnvHcqfOw5i1
 blmCNEEzKF3sMzUz9dEG/8DJTzlw+DFExjJTKa1ijbIfTrBek3+G3n5pwdH1KTrYV8Kt
 79MA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyJGvtW6Fw2QTDPrQqGUgICUVqRWtBS5Fz54M0F2zjbv4gOplXZ1KK5oY0SdSjgYAfvkG7tecVpfHJ@nongnu.org
X-Gm-Message-State: AOJu0YxE/vs/R0Zwwh7RThA/LmsSIrxSNxxw71MS2l7Qxo8jOGl3c5Mn
 IvDXxAuWOQ2a/dEL0Gm5TEJiRcUSWVRqU1ooGsKcy7RfBOopQKBB6ihRTA/eWardgsYaCnzosps
 oSc5TsCu1gW+nSKbRqDQVlOqD3s3qQFuOum47DeEHZ6i4kb0OBUp2KCLGeA==
X-Gm-Gg: AR+sD10LK3+HyABPl203oYJEbXBbRcyE+7FsJzIkgMEF6gwPvXCbKI3gVQy1UJ6Y7UL
 Ch4Yl/u2w/T7ZLAyTXiq/ahsBOFFoIkkwWVWstp38oK0DuhLelvA9w4e30DF5SKMc8hpW3W+Sx/
 grFQ6bVLWVWXqSKo2uyE2+naSQaySEVyyxvdOlXiLFKhWP6I/VyoGPhpq6PEk6ILpOlAAAVnrBE
 x0mykDH8LF1wBNLFPkonTp5HiuV90P7LyW1/GcGDYa5+k/2sDcpYl0ylEVKDCKk9DQEMWcHLaZG
 7hpCd3Jnagtib5B79tGL7JiC2C/u2gwKWv2o9T40dS3WN8PMp6nQko4U+SxgrT8TScjBpNzumnG
 See50n8krPha1LxbWH+Bc03TfrNEKH/h3D4VfFAOGKkvavgcdNrU=
X-Received: by 2002:a05:6102:4bcc:b0:744:cb59:d6e0 with SMTP id
 ada2fe7eead31-74d5ad4147amr1545377137.0.1784822765238; 
 Thu, 23 Jul 2026 09:06:05 -0700 (PDT)
X-Received: by 2002:a05:6102:4bcc:b0:744:cb59:d6e0 with SMTP id
 ada2fe7eead31-74d5ad4147amr1545329137.0.1784822764685; 
 Thu, 23 Jul 2026 09:06:04 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957afb4da8sm2762255e9.12.2026.07.23.09.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 09:06:03 -0700 (PDT)
Message-ID: <dc629f33-1d9c-4e1a-a925-384e8cd1e9fe@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 18:06:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/hw: defend against weird elf headers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260723125310.33707-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723125310.33707-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e742j6p/ c=1 sm=1 tr=0 ts=6a623bed cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=t668wg_bggP6ZPi5WjgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: h1WVqBrb4mKs6JQhPvvw_ZxNzxNUIccs
X-Proofpoint-GUID: h1WVqBrb4mKs6JQhPvvw_ZxNzxNUIccs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE1OCBTYWx0ZWRfX2WeooDn0F/l/
 6VZlonewlvHE5nQ9yDag5/qHt2VOBls1PNZR/Mb+cpgFyoj6SHq+tYF95ai0NdxzQ0ecCZrzDb2
 TtZbkr+Ah+9nHFfM+MgiRHHxJcAwnOg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE1OCBTYWx0ZWRfX+j7isDM28QTl
 7vCKntutvxGMbXW8PFmXwPEP/Cpsemn3LgYNkpjhfInGacVITizZVs3Ny5Ph+Yzrjni684J+ZZF
 ymYKn/CpNa7OcZ/rPyjgmvxBkLyshT7iv2/IO8552Lx2dMz3LDcDxS8Pi3ZHgzoXs9iPilWsY13
 NmzjlNQciynYQi8dO9xQKcNimlEfBhlxurokoO/c1/ueiMNbaeEgA6D0N6DY9tQXsJ7Mt9hXzkG
 TKWRI18Aa1zp3tEA1WKh0FEJxUOhZHz7QSgLM5nJBTUMJl5mpxRfFZ38yJmYSy1ZUijbyqYP2Hj
 B9OQ5ib6qNBZHSxOxuUkh/ui1QRvErPMhhE0zgywNlNwFfV+bL6XSzjHh8Z+ZZBZu6G/+nrLn/r
 EAtm4MzOw/k5nf11vx15wVS5hP6ZgCWBVPMcEGNSMvSTMiZiBAGXe3F6T5g2o4KwKfHSP4fWenh
 KHQfUmSxK8ojhNf3zmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230158
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/7/26 14:53, Alex BennÃ©e wrote:
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
> ---
>   include/hw/elf_ops.h.inc | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
> index 9c35d1b9da6..c6d94ef760c 100644
> --- a/include/hw/elf_ops.h.inc
> +++ b/include/hw/elf_ops.h.inc
> @@ -427,6 +427,10 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
>               file_size = ph->p_filesz; /* Size of the allocated data */
>               data_offset = ph->p_offset; /* Offset where the data is located */
>   
> +            if (file_size > mem_size) {

Maybe use 'ret = ELF_LOAD_TOO_BIG;' or add ELF_LOAD_TOO_SMALL = -6 and
update load_elf_strerror() to return a more useful string?

$ git log --oneline |fgrep hw/elf
159fb790e48 hw/elf_ops: Rename elf_ops.h -> elf_ops.h.inc
1fed4cd04d8 Revert "hw/elf_ops: Ignore loadable segments with zero size"
62570f14341 hw/elf_ops: Ignore loadable segments with zero size
e1fee58fea3 include/hw/elf: Remove truncating signed casts
b4c4c1f1129 hw/elf_ops: clear uninitialized segment space
8975eb891fb hw/elf_ops.h: switch to ssize_t for elf loader return type
f413e514a91 hw/elf_ops: Fix a typo
5579b524b0d hw/elf_ops: Do not ignore write failures when loading ELF

"hw/elf_ops" in subject is more precise than "include/hw".

The fix LGTM but the error path could be easily improved :)

> +                goto fail;
> +            }
> +
>               if (file_size > 0) {
>                   if (g_mapped_file_get_length(mapped_file) <
>                       file_size + data_offset) {


