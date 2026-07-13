Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49067C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEKx-0005FK-0J; Mon, 13 Jul 2026 06:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEKv-0005Eb-CG
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:56:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEKt-0004hf-TP
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:56:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D9duWk955892
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YrYyCT8vzzgW9v1eb98IRSXqUawdDOedhrQ5pyZ00jU=; b=I6hUUlu1q/wBeZ0I
 5dl23V6B476NkTRV76DpLWhioG97Wpj1xbswiGUZw5UYETjNj0Xz994ZZqdqnhGu
 s4II3PIXfo8Ra3U4YBQ27O7jZS2DcdvfZyqfXetQEdrPcqjXobhtyUUSKrCxoiZG
 7gQSltkwp2Wg0ndiLVtxVo7mReMw3mjyYlrVh6K+SxTb8TT4MogPHfU27VLB5jrn
 9Dvpge9UKrs/MGurHuGSYbIwP6Ur3cA/mL5X96twCoVoJAZuXL5lQOZ5O4aACTBP
 tqBUXdnYF1IWkhwPKf1DnsD9kz+hPCwablCQpkSXxugZ+LfO/N/h/3hZ3RY7Pzh2
 bk8nTg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9r8mm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:56:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so51119571cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783940190; x=1784544990; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YrYyCT8vzzgW9v1eb98IRSXqUawdDOedhrQ5pyZ00jU=;
 b=Qw12tcjpymz7c+cjj2pgMpztdPBD/aDxq9PNytCx6QYSt4uTSR4Z/4GmukIqG/TzLy
 +qLebIRUBTAUVpKh8o+zhqK6mcEF1wArd2JyIQv3cwt6EZ78wUSk1SIeIIXc4SFgQJFp
 okeShsrSIo2aHe7liXUusfdSa7hz++p2UWcRBZUMwiPSAR2fOR+xmaJ0QnZrKTRfiCYC
 YQFp6X3FZk5GypE4YmTRe4kKZhJIMP4oi1mxcuf6HaRyg/x6dl1zyEWSIMGCgPz91YLk
 YT4vxUlWcug+z4Q+hT1T6qJoakJ8Dk+ISyX59i/UQbez9KGumPs3LB0xSt+XiOv/TeX+
 6W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783940190; x=1784544990;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YrYyCT8vzzgW9v1eb98IRSXqUawdDOedhrQ5pyZ00jU=;
 b=jQKIzpE0GmtvdFIOg0plIxPJmgTikKcOmAWjAh5JP8szI8yUiahqs3o2P3XGs8ZIMi
 uy5vXOO8yJJBdepv6jTqG19yTvUBvLDK89cEmF3A7OOjeX05huFx0Y7OTEzkVEUqZISX
 RdGJuJMh/PNA3pQCF0gqsqUotG5g2ot9ZPIbBLyLKi92RHbV5T/pLhL19lZo/8UlS6mG
 GSDgmikJsVOvzum29zq5lg4MscnnGcKM+1gGmoINdyaVLdQipYXIFNxmR4P0v4S9IlKH
 1hE9HOHBx2ApllIzXGQD+UaPvh5GhgW8TJYoGfNotnFqn+CWpjKjS22hK1Gjd4jAbrbq
 Lwaw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWr7TyoDI7H03L3sSIFemxXBGnDviuLxDfNb1QdIrVBBLw4LJ+e/4FIEjJboOgLksQjcz++ACV6vJs@nongnu.org
X-Gm-Message-State: AOJu0Yx8KnjMvURsC2uCWPG87pTDFHETnTacr2ve6N0oFDheEyfdVNtN
 UwwituUlIwlyNEAT50ZZ9TiQts4JmdIw6JuQ0EoQLZ1jeRsdloPv58MbRrkdYCyx8UCo5FSRxB3
 9CCiXPD60BbiFy/ENmMg0+gT1euuzv57JQEJ0f3Q7DaCTY/Oud1gIujz4UofXtUqUhA==
X-Gm-Gg: AfdE7ckwzhvH/1rhi3Veru17kmpiaNKdd1BZmIks3Yj6H1jDYslIaStXAEwh+yH/Fjn
 OfBV4p65vugkRPr3A1g4/Z40/vtDfkpibCtiDss6E7RiUAs/sI4nUIG4+y/386EO00Q4pJlDLkG
 ueYYp8iAkLlLqjQEHKrjuLTvOMqmjlzsMjU51q+Hn2X/YiI6+mCsYIEpwDPdqNSbciDSKHams4o
 PAn02KTyOZKHuETNGZjnzY9GJvVGf6HaUnqV+wDbjOw9vOY4WymaMxa5+SLfwLdgv0SOxDOKxcJ
 EFm8w4Vn83lTtqA4jbaDbcBcdIz+QD4bstqRrFAPwmUXkNzQqiSHD5aUAbkE4R+QuOPQqrOtHEd
 CVuIWoWkCIyRNipd1EMxL9Vcd8yfLy16cOhSFdU6X4ALYUBWUPj15Re/2f8oq8Q==
X-Received: by 2002:ac8:5a87:0:b0:51a:8f3a:13b9 with SMTP id
 d75a77b69052e-51cbf170ae1mr87995841cf.16.1783940190403; 
 Mon, 13 Jul 2026 03:56:30 -0700 (PDT)
X-Received: by 2002:ac8:5a87:0:b0:51a:8f3a:13b9 with SMTP id
 d75a77b69052e-51cbf170ae1mr87995731cf.16.1783940190040; 
 Mon, 13 Jul 2026 03:56:30 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ff6casm424080805e9.5.2026.07.13.03.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 03:56:29 -0700 (PDT)
Message-ID: <047b30a8-2d31-4322-97ed-78208e0e121e@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] hw/dma/soc_dma: Remove union from memmap_entry_s
 struct
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
 <20260710105907.2570621-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710105907.2570621-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExMyBTYWx0ZWRfX3u/7rKSUhbMG
 4mgdx6LPCky4XMfgTe2y/XVZEw60nf1a8vRIT5RfoviFYKKml2jycbMo+Av9i3ms458yvKR1TgL
 bg6ijDmjm+HrXlOJS2OhArFVjmgtvSbPeVBFdcsVOzViP7bFhyPZb0rG56abJn64pOkz0kX2Sfe
 aT/kPSUOThxcEt8bE//2JvTc9ZK1sKliG9Cvw4VmYYiSNG+Jdw0ae/Xfxtx3iH0bT0YIeRseXYm
 wMJ2JvJyO0YzqzqVP6eJAqWNqTK83U/jW4YMx4Dq+F3r7nmcmAglUl6ht9L+mE/ptbaEU/wFZw7
 cbD/pngJdvaeiscQgYgGl/MYlxle4ll9Ut8wsGE3fd1JefNX4A6o/FS5tGj1i2/+mGHqe2DEaNu
 ZI36LkGLjdsv8EtOBkOv1wiFK1TTYXuSIRyOZeBmCyGDH177OKg8ZAnW7tvtvtz2O1AIDn1ky42
 +vPDPHweBzblTSVlECg==
X-Proofpoint-ORIG-GUID: mUDI_Z16L559TEQIs8MgnlAW9Ns9B-zJ
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a54c45e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mUDI_Z16L559TEQIs8MgnlAW9Ns9B-zJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExMyBTYWx0ZWRfX+IxO3sV0ZMlc
 J02vf3dNPyOBOH3DtzfkpxAGEkLCFfOS0iwnF6u2LnolF4hja2TBXlnhkt02wex5PRssUfdMSLO
 /QLaLBt9EzJz9smN4523WVwQ+d3EX6Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130113
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

On 10/7/26 12:59, Peter Maydell wrote:
> There's only one field in the union inside memmap_entry_s now that
> we've removed the soc_dma_port_fifo handling.  Simplify by removing
> the union.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/dma/soc_dma.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

