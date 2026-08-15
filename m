Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44090C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 14:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvEwS-0007NZ-Gl; Sat, 15 Aug 2026 10:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEwN-0007MQ-7Z
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:00:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEwL-00041N-QV
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:00:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDNlk1570700
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U+TvRISCMkT/wBoP8QNIsb4IVDy78nTrenbZDEjOmno=; b=jQbi3xLv68pJvzNx
 D16fwyjOFkAtgtoULhz7A5yGeDIwrxhZpSogr/+gXKdr6CWbcedHnn5Rbb39I6Q7
 yhJidFqYwNMCDOwuJKdhp4k+xdFew0fga1rtLn+BIbRJIWhZjdYbGUdNhk65YbIe
 9TBIdyMJMDfwlBATYOIATVaGQnTl5gXYREvCGQbGzWrJxyS1Sd6Eoj0Ot+w179MM
 1KfQMdqkk7s17mFZrdwfdfk1PW4W1B+Npx5ZcJbgnZrsSnmTFg7vGF2wupyeduRF
 1DkxuXJfecSmx/Lgiq+jP9mJ5P7TUZ33l6/G1NFdYeDgDM5MJABS8FS6KFMU/me9
 K9UUaQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf14gy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:00:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e8004d60eso361683685a.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786802448; x=1787407248; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U+TvRISCMkT/wBoP8QNIsb4IVDy78nTrenbZDEjOmno=;
 b=O+Stfcogqwn3jokM6/DTmDqJkMXr/THp3GZCHP03UWGtN5RgBCNJx7Jhg8kjlFAK49
 rDjovkjbILTU2QqCBTKl2r44NWhp+IcSwgch7h7IkmC+AD+mcO6KU0RldsRRp/w6VXw+
 l2WOHD5a6nGmtyloE+3Bse3Z9Ii8hbTbZPjCxpRQTtxo0O/Wyke7FFlzQvNTcnKYLhLQ
 JB6MnUakitZ99EJZjqkfYFou12HbGjvKyu1lpx3KgmfyV9+vIlGvE4ut124rXxqBUq3z
 hLs2oKtDJOOleWyNS2zZCKR5CZsQRBFavoY5hRyB0upkZP00WgUziosHDK8vFMuzZV8p
 Gy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786802448; x=1787407248;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U+TvRISCMkT/wBoP8QNIsb4IVDy78nTrenbZDEjOmno=;
 b=fbbLRzJiYdV0wEMV2yLCCQoEFVr86pWKW5in5DAPPeswliiv/COSW/DbZWZIcAOvpH
 J13l2zy/vtz+7aTBNpkHIJb9eToEppms5cFQB5Zfp9qOze1c96NsF/tsvJzj582t9fYv
 /MUF/F3GtjQe4CashGUBZC99Ax9Rt6eEEghp7KD8rRDPmvwfW1mlc9RsKxE1Pk30GduV
 IQZ0ASEFbPl4w80fvWIIB73H4QO8qThAd+CZx18qh9P7GNYrZsZszOUo0rN88SsvcDhy
 eBo+Pp1d76psJ2E41qbHj+F5tRXwgQqoIDkEmblwsOeUhyLG0w0HI+NGZ/b7x2OHnPiU
 Pv7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9dCNaPTX5lVifjgyW7s3KGX1y89W86vixryktnL8EZspnAYdRsJtUBcbq9zk2PLOaKbAyBjMI42Tk@nongnu.org
X-Gm-Message-State: AOJu0YzMei3vxt63SF04DnGz9Sup6my+qexfeWrT7mdlsbvILchraAMU
 lll2R2FA9s0EGWob95xihhQmS3CBwMAC3HJIvhU0H+5hHS67qto1us9QtkpAfidTMQ0jZ2sui/i
 9E4mzsWwvHkfn/viVKK3rMU0QJZmBgyFf+4KGjrXhdaaEo92kXyFWP9H0qzEkOt63ULps
X-Gm-Gg: AR+sD13woVU0YkPjxyW5CeA9QR4hqGW4ZkJ26D7PJS+9pZhSUioKX1irPqO0EvQjdjT
 0UYJBZm2QaElM8FehEgBpvwBh5yx5I5iwSyIsbS7jWUUIZHOv0g6E8zlzh7Ca2bNEZtRYuHR50J
 ti2rHZ2Ol6IZZ3MY7Dxy3pF/ohhQ0//JqfWJE0efbomzk9LOJymPWH2j+M6RHMacKfdbPYodvpa
 mEQWRd4HDb4iXQYlE91KNA6sTDR6tIyZShU7rYn7x3ZxvDeiRhaXrtI/u1v7Zq+jEQItXtol7UU
 pY8BkkoobFi98MLRTC+81/LIqG/p+1jWzxCk/4mBNSSi1b2xjGJaRd2cpgMW3oC+Al1pmoIVlYv
 WxeOElskhtpaLzlTr1BHqCvko8mV1G6XsOvs=
X-Received: by 2002:a05:620a:8f8a:b0:916:10f6:780f with SMTP id
 af79cd13be357-936d22cdfb1mr921409585a.27.1786802447785; 
 Sat, 15 Aug 2026 07:00:47 -0700 (PDT)
X-Received: by 2002:a05:620a:8f8a:b0:916:10f6:780f with SMTP id
 af79cd13be357-936d22cdfb1mr921401285a.27.1786802447211; 
 Sat, 15 Aug 2026 07:00:47 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c1307sm17454839f8f.27.2026.08.15.07.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 07:00:46 -0700 (PDT)
Message-ID: <f1c082b1-73c9-4ba6-9e05-e3330c42ecfe@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 16:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd: give the RPMB vmstate subsection a name of its own
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260814183859.4034017-1-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260814183859.4034017-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a807110 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=5RHtEPMUJtLrCEOe:21 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=6rqHouBjAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=DHScNr3fFKc7-UrOyTsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Hx1yvPaMooE3kwe23bt7:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: UaAWlBbjfukkIf42Ut5scPo0lFQyDozz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMSBTYWx0ZWRfX+ZOduSQEApjJ
 Eu1P2xatdZHjJd2cWUnmtw5K26Ueq4ZoVWPGDagb0+Cb3/1aMpFwMsTAStPcO9X1k/jKYwMvXth
 mW0jdTvF3o04FDuTeOP02VGUtHk9WwkYRyEPCOJqhFLthx20JsFDvXJsOmI7RqftEZmCOxfvLEh
 y8A2cJu949fSScRdmMGz7lhvLEipMGCxNyCMJh0wx+eTJviqxY5FTLrdE/iWlkj8PUDg/hP55jo
 39AqgBoSXYkrGUpIW8cee7cAEfGa1mAgFeWeGKcMJTJl+ZNCJDu89p5pktAh5M9a87nWeVVxvVg
 v03IzDf/nqrGcWYvf3atoZ55iefZLP38EkrpjK9JsUQZ1awBEEoMCbi18cSXSGkGrhVqjETJIo1
 aDadkTMzjwtAjYIuDSd3gl5YDcGcnj+MCBQI8yf84O2s5swkbQ/enV0z038j5rrG9zTTPPpV+l/
 3vZYn7uBi100kPezdiA==
X-Proofpoint-ORIG-GUID: UaAWlBbjfukkIf42Ut5scPo0lFQyDozz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMSBTYWx0ZWRfXx744mn35seaI
 aokKGznBWx7pP8aPEmitw7fHpwXzjq7p9UVEG/+leM/AD5lbKCVeTauFOAXwM/Bb2UXttlCOYoi
 wBV3+NTFjysgKziPLvItDHbHtYlOtQw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150101
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

On 14/8/26 20:38, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> emmc_rpmb_vmstate and emmc_extcsd_vmstate are both called
> "sd-card/ext_csd_modes-state" and both sit in sd_vmstate.subsections, so
> a card with an RPMB partition sends two subsections under one name:
> 192 bytes of ext_csd_rw and 353 bytes of RPMB state.
> 
> vmstate_get_subsection() returns the first entry whose name matches, so
> the destination parses both of them as emmc_extcsd_vmstate. The RPMB
> section is 161 bytes longer than the fields being loaded from it, the
> stream is left mid-section, and the load fails:
> 
>    (qemu) migrate file:vm.mig
>    ... on the destination:
>    load of migration failed: Invalid argument:
>    Section footer error, section_id: 38
> 
> Reproduced with
> 
>    qemu-system-x86_64 -M q35 -device sdhci-pci,id=mmc \
>      -drive if=none,id=d0,file=emmc.raw,format=raw \
>      -device emmc,bus=sd-bus,drive=d0,rpmb-partition-size=131072
> 
> Name it "sd-card/rpmb-state". A stream written by an affected version
> cannot be loaded by any version, this one included, so there is no
> working format to stay compatible with.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 8ef4260a3f ("hw/sd/sdcard: Add basic support for RPMB partition")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   hw/sd/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

and queued, thanks.

