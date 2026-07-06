Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D908C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgqB3-0000QT-J2; Mon, 06 Jul 2026 16:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgqAp-0000MU-SJ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:44:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgqAo-0006eG-7O
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:44:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDwZn1478003
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 20:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9xGhwWrpbe2L+1gr+533gIOCrY3WBXla9nGBSKL6CmQ=; b=nzaSt06SI2ZXrGhG
 Z2mQkF4PGaI2CW6aNbm9vxUJmCoQGXjKxhNa9x/s8LbJSgPf+XkdBKr7DEG4jd9f
 L8i8AaGCLZCJz6DA3URPxJjXT83q3flSFp5WInOUfhYzv1sJ7x7TIr6pP4RQlT1Z
 l0vVoFgp3tmGDtR4/3HpgmjneuK5uzVlIwysKiBGr9UrKAMl2eLoznmm/A7qetau
 8FnY0IQSiKdsS+SLhJl0Y/1ts2bAGyZwxw5+R3ONHRTZ291/fDQCeqKAD2N4A6pB
 5WKRM7ztWkvR5Qfw7EOnHO8tzIMIF8hNqtXlrIg18BTLJ1NVrByfFkSNjz+ui7BB
 wijkpg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsb9b5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 20:44:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e56b2b350so699377085a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783370644; x=1783975444; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9xGhwWrpbe2L+1gr+533gIOCrY3WBXla9nGBSKL6CmQ=;
 b=XcJAi6MtscZmc3RjrnC9oRzennyrg0QzJfdtIM90J3JJQs0Fu6ZXi2/t/OsW/ao7mj
 XZK7bEWLgW3EM5GglAwkoBXf9L686bZidFcwfmTpS8AAs4enSFDOaz8iz4PgVDtnKxfj
 9iN4WUTgb8dnktkvhdcmQYWAwYfivsLRQpd97wGMVk5nKvXOMSKgtqFVXSFmA61OsW1Z
 U/vBNxh0cc1rw0BjEOVPG4XV3eD7O3qf/KSO+aTCnmgG0aZL+WD3588TIUkknP66/X+S
 cgdrFsOt6ZKQLq5rNYyW6bxAWAYYYQXFGaRqICjDlJRjI399/YHye+CAHYHkDpuAo1AC
 o5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783370644; x=1783975444;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9xGhwWrpbe2L+1gr+533gIOCrY3WBXla9nGBSKL6CmQ=;
 b=VZt4s/iVrqeLSwTHzXYuXffM+rdrTQgidzORYtlba3kL/6uIjnK7VPoAlquJSZNB3p
 7DP+H/oFIwbeweALsEnGVGfACqRxpqBSIh8Fv7fCYnHtklClpFaK0nB40wZ68kAlrNab
 2kMBcHa+Pz7RpH/63PkHusp34FDvUqAsD6fLgL1sGZr/a1CdY+KYu6hRNtjvtDpbKduO
 fPnNqVDpnEDQfWdMam67W6JwifF7RNGpfdGNtBafycwtwV37N1ix9YgXDGoeEdLYQe51
 TAwCH6fPWOIna1V+0xoe6B2B+LncxQvgrx/6DnWjLTWskpsUgLO5VFZNcmairl1EAhk1
 AKDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2IVzLnkZkwV5FYisNOaKZSy9Mr+VO0rHz6vA9FhPEFDxRw6eg6Rm8QNgRknLcmT8JiN1wb22ivgfb@nongnu.org
X-Gm-Message-State: AOJu0YxRKt7qHpZ1hwF3XRG3jt2yvzdk1jdeowCgN7RJA0DAmnbKnlQl
 NYlOaCUKL1COuHupZVdfCzkByEmScFo+mrTvV37R00Iici0lD/a/WxNuEoJ7L8UNgwHQJ0W6jwY
 MCdGzToQFb/7J7Kwfo6jqgjPo8U/oO6LhDm8169GCHrton9aQuW02KnZNoZ/pNWDaDg==
X-Gm-Gg: AfdE7cmuP1iXGODNfh8nDU7GR9pb/uRom8ubSwHmKO0WjKvecPVq8rtgR1nqFxh5gnO
 l+9or0UffW3su1eJMJmth2GcCxsmh8NnMLnF692qUh6Kn4LnLQ8hX3DW3515XC5otKs9uvJwGiZ
 1Ur78oCgZVCflwGkApF9fylQKwTef0hfzGVjuLj6vV01DC4MfK8frbKa/FTgVC31oaq+DA4ORnm
 LPi9KbJ9BwHTEgLgq5IM2G2oxyU/I+Pvqc/4V9Poi+p8Vi2rmVZCMb9Tr2T3pyYnne2mlQHWUTf
 BVklR1YSB5N0tm+qTxurm0hkVdBX2TK8K7Q2NcIHBei8pK3MSvlVYn5tcv3/418zhSgmVBH+NNX
 v5lWKEsLHtqu1lrNIfyZB3oqFeQeW8+KocBu1gQhtwlGPICwxugi6f8xQJuwfQQ==
X-Received: by 2002:a05:620a:4086:b0:92e:7d1f:d3aa with SMTP id
 af79cd13be357-92ebb500799mr294956485a.31.1783370644143; 
 Mon, 06 Jul 2026 13:44:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4086:b0:92e:7d1f:d3aa with SMTP id
 af79cd13be357-92ebb500799mr294949285a.31.1783370642937; 
 Mon, 06 Jul 2026 13:44:02 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d843csm26690593f8f.14.2026.07.06.13.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 13:44:02 -0700 (PDT)
Message-ID: <71ed76a7-f52e-4412-9e75-da9aae1f6b28@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 22:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/vmxnet3: Correct bounds check on tx queue index
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20260706175408.905362-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706175408.905362-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IGStGgOYHR9vllDnno3fAkkPhUP46zKD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIwOSBTYWx0ZWRfX37dN90Gy89iL
 DD3GOoBBdXT0CV1RNkBf72Q0oP3jKs8kbpSJqcY3Dk3WAJnOFuXIrjWHesoaCpk5CWoBvSiVUG3
 dOr16+YhlYfqkokm8Dsd+nkqJOHo0U11hT7m8X7/be+9hS6vxeGuLdG2YpHjhToTXw3liG3HQPL
 19iYizUEuwZvVQW8s3r2U5kmlVHQj8E1032jOSZCfOW/791UarudE9DuWawpGt6N40BBHL48nil
 aDPTQK+rV2Ljre93UgMjlX4lD8iZ/Gj+iiTWUl6i37sWb2Aw0LPObN0PG5eBvqJ88HZPE/2oGPN
 XMTqva+oU4wl+oyGTbHxZZQN9Ib8pXvODZ0rinaAmSKKXb+JkKVui2Zl1Nozx8xd/Spv3T8nGc4
 3EbwpkueEvvPxe/OTp+CncCKrrr2qKAq+mHvNI4TmL+4PZ7hAuBf9fBm+M664T/CxbPNTOu3VYp
 92lhRG6HYuA08HPWSUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIwOSBTYWx0ZWRfX7eB70Zy/TWsy
 s01eneEE+juz2djye3holLZ1H06Qh2+HaSWn7B+oHX++GvYylupFdcixgb/8/f3s5FmlnDgX3jU
 6Mm8gLG6ALGOaIJMPTqrTcQgTUVMtiM=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c1394 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: IGStGgOYHR9vllDnno3fAkkPhUP46zKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060209
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

On 6/7/26 19:54, Peter Maydell wrote:
> In vmxnet3_io_bar0_write(), we try to bounds-check the TX queue index
> provided by the guest against the total number of queues.  However,
> we have an off-by-one error: the valid indexes are from 0 to
> txq_num-1, so we need a "<" comparison, not "<=".
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3780
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/vmxnet3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

