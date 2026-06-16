Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19414CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZHxU-0007kI-GN; Mon, 15 Jun 2026 20:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZHxS-0007jv-Cl
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:47:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZHxQ-0007ym-D4
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:47:14 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0O0jm1484211
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yEbcZHsahb7ZTbRQJ4xXlmJFLHwT0FerCebdHDlTfjk=; b=aTkK9v01/TYxSpjj
 llGipd1Myxq9/70eRg0S3LQSbBvTB/3XLAFmALVd53T9aWGKti7jF8Qt4AWp3Nj2
 S3vWmwrH0XsjEhOZqgUtAha5eH3lEm1mdckjHkWXrmHn3DIVTDZn9FEsAPr3wfHs
 EOCKI0jOES1StLrjCeBjVL/HdXS5TbW1MEsfrTgFq4HLRi/XdeTqs8cgurMtOT2t
 5oEFViDocaokHnyAWwzyWC0xqQcYgBhAM/64gGQ//OyLi6rPo+J3pWsq1jAtFQ+D
 DcgiS1YoR/ssqR28p8IRgWtN2PnM3PcVVekcVLNu2Ud4zLTpT2XFFan65D25wzn9
 mjH70A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjuvex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:47:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91598ab3a1aso460543585a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781570829; x=1782175629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yEbcZHsahb7ZTbRQJ4xXlmJFLHwT0FerCebdHDlTfjk=;
 b=gfH+SrFrlVYZ6V0fFRwbwWbKT9pnEl2V9V18vsGwFO8CjD3WUYr+O0My1UelYxUY3T
 jKCVDa0Cru3W5pcyAGyAA3c1idXpT27e6YFPg0xhkPrCH8H/H2ilWbxNnOk/jIq0UZFl
 U//8p7yl+8L8uTTXc46QHNd/0G/4ToBgxHLkd5d+5/62y/RmD13wkaNpnnPM/ihadGhk
 2l+RaGKf15AK7+ZAQjraGPdmaxpOwg/sj8LgRgmkdMy9pQs1QlGNCDch/gyaJD6K8pEQ
 ipI3srLDcTN6JjkQfrLHbAaTLkBKFRDOe8CGqLIt38gO42NDFYteMtq7ElDCjn+yqSAk
 Na1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781570829; x=1782175629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yEbcZHsahb7ZTbRQJ4xXlmJFLHwT0FerCebdHDlTfjk=;
 b=UdCc1g6nElYboOCxjgWofWvkkWVbTQ26vrlF7uneYTN/cTlvsDKbEB93/kL45hkRh3
 WjdBtkA9WK6QV3JOxHQ+CRYH++e6D+dgb6E4t/MEKiHRoLH7xzb33l8rOGUSPBTs1O4b
 TeMBzluvBWVRPRiPMHjwSwXYfZDLIFgWXLWmDPgtCxthvlTJh191IXlryYtXplroBbWO
 Ry/hlqnBP4LojBrDgD4cepXDIACy3k9DFjNSk++mN6xXqF/giMzmInk6HmK3hh/G5nc7
 o/9iiqqm3AAESwjVFo9uq7sbWnUFyTwq+R0fOnultthxreBWY9Ee8UWrktwBY1xfxp/s
 MLGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vg7KkONsczBk1rRDWa79NVp4Ua090hpct+/WVZdge6GsRiGD1J2PNJOH9LgnljSskBoWCEIH8gH+h@nongnu.org
X-Gm-Message-State: AOJu0YxaAsaBo28Lo6nWKvks0XT0qMJJoy9o6hfNoe78cWP9dXxWV8dE
 9Mn1QoIyukT2CCqB0LPSYycFbKXlJIZuiqqnquH5DzisLYf06hSihxbKjRzpS4Ae1IDZlWXxEs7
 WOquP3rNHT5oSuxqHDrFalZ2aXUinEd4OQOu+cdqj/gxTPMoQXyPRSzUxkg==
X-Gm-Gg: Acq92OHaWRULCp27Y7uHJ/+AI/amcteFKNWTfVECinJeP6K6TFEvOq25MZZE7D3lgLG
 AMKpVrvh1PW97gpGNlHOodJ4nfLXdfh+tBH0dmiwwLFx26SDLD9CATu2t5eAnkDU2stfkVXq9Wp
 6n+jY036jciLWUjJfQXVqPyPUFRKyWQ2NMmXYr2OpNj9fX7+MCPnoEvczpEAY9bEEMX3/Z0cHE1
 xTDQpPkx2THjDiq5KV6FG61IeiHjCvw2ZLCN8Qlfs/w83FypOUv08d9ioNLUIszXJzuvwJuhhHt
 aIeaAyMltClgL3orKNlTk5JH8kVhw8ZyNaDpFR//fSmaptNANZY6iWdpRMthHGT8XTPA7stZPIT
 J6PCF2mSxq6MKbJPrAmw/FbNv2a97/P3vxnJB5X35MAE2+1076mUVl+IthqD4I61APod8bGfl
X-Received: by 2002:a05:620a:31a0:b0:915:9f28:6741 with SMTP id
 af79cd13be357-9161bc1ffc3mr2490655685a.11.1781570829027; 
 Mon, 15 Jun 2026 17:47:09 -0700 (PDT)
X-Received: by 2002:a05:620a:31a0:b0:915:9f28:6741 with SMTP id
 af79cd13be357-9161bc1ffc3mr2490651885a.11.1781570828530; 
 Mon, 15 Jun 2026 17:47:08 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa891acsm34777655e9.9.2026.06.15.17.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 17:47:07 -0700 (PDT)
Message-ID: <7072ac41-461a-4c9f-a036-4eaa56e1f2cd@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 02:47:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] igb: Implement TRL throttling and timer resumption
Content-Language: en-US
To: Josh Hilke <jrhilke@google.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
 <20260615-igb-trl-v4-5-cf5739bf529f@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615-igb-trl-v4-5-cf5739bf529f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwNCBTYWx0ZWRfX1ZTWrtlhIOpj
 DA/Bc4t0Jfl/z146XoarKONK/OURYLpFMFLDCMqnIuc8FIfuehjrnfUpc5IO/tNw+JWQm6mBlub
 EI91Jkk/iAOlsBE1HWI7kXk/MYvDEAaLO+TKQSyQx8RDTbgGpsdHtDqo532NbEnPkPUURGpDXkY
 XmosYWX8P+uzcAkxmheKRvnHzyrREIwbZaCC/YwU7B30vrBMPmRhX8tgivAd3EVu6eG/UzSqWu3
 I6n/5w3ICHjmQreu1952CBu6cXx2vNdpfc0SDItddXpUiGLsL2yiieZR11vzliuDJ3L/zL9hgkD
 tOq/MkrNt/pdBx++wz7fpSyDA4OambrD2NtXALQtojZJG/qDqIDftJBNIddGRCn03ifgb4N+dBF
 3bqx+Q4upIahMvzz4QwEfR0R8l5KmEarwlWYOnPTpFabj3p79rMZqJX77qWWt7n1NG2sp03GjCE
 6z92l1DdSsPty5VUAoA==
X-Proofpoint-ORIG-GUID: _Dn55I7B6KE-ZRR3IYskecWGo73vrM-J
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwNCBTYWx0ZWRfX5424ML8Cnm6p
 p3NQSoxdsyrUieo6IQqfSOwHw/7hPMZdPzxqrOVx+e6WW6KUKE6QUzxy1STJ3FTmjBR51r8JFeL
 Lt1DyT4AxoUyrYkTebr16M/AXmbRlVk=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a309d0e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=1XWaLZrsAAAA:8 a=qJzJuyYVcRHQk2norCAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: _Dn55I7B6KE-ZRR3IYskecWGo73vrM-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160004
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Josh,

On 16/6/26 00:18, Josh Hilke wrote:
> Integrate throttling logic into the transmission path. In
> `igb_start_xmit`, check if the queue is currently throttled.  Accumulate
> bytes sent, calculate the transmission delay based on the configured
> target rate, and if a throttle is triggered, set the virtual timer, mark
> the queue as throttled, and defer remaining packets.  Implement the
> timer callback to clear the throttled state and resume transmission when
> the timer expires.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_core.c | 42 +++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index fac4c44..17eeba4 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -876,6 +876,12 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
>           (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
>   }
>   
> +static uint64_t igb_trl_calculate_delay(uint64_t target_rate,
> +                                        size_t bytes_sent)
> +{
> +    return (uint64_t)bytes_sent * NANOSECONDS_PER_SECOND / target_rate;

Please use the safer muldiv64() helper. Rest LGTM.

> +}



