Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8974FC61CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wycby-0000CM-Ga; Mon, 24 Aug 2026 17:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wycbx-0000CA-MD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:53:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wycbw-0005Sg-3m
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:53:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJHafx3416909
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YoOc4GSgqsiLx1znxT5qOCAzq/nKrAwxNGMECdp/i0w=; b=PGL45OQ4OWWR6Qru
 Jz/o6QnrJubacSCUPEvhFmFKv5KfG6CC6zhSm8Az/gIkETZN2zO+pmHjAp5rX1BS
 sxVBjcwoCqYnmowzH83W+K3bZPV3KVGodVX4mcvQkrWdUflzC11harnPHjOoFmLe
 N9KCL9vq8X8wztjJwsfm2nfe5e8RCo+PqQJgoMnMQFYIA8z634m7nDMzQql+c7hI
 HWm1eug0FjeTDnIeMvkaxXytrg3vnVPSwV6uNfr1XSq955XiqivneBotVNKPgTJ7
 g/Mti08gPNvMgJzACG3rLTeVyLN8/K+vBSGjYNKsA+BDdGyTCbqsCj54rKCgb0YH
 Y1OLhQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8t3ds14g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:53:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso4152509a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787608419; x=1788213219; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YoOc4GSgqsiLx1znxT5qOCAzq/nKrAwxNGMECdp/i0w=;
 b=C1YvWvu0YHy6A7Od7sIO0rokxRp8kKSnasGiS8IZFq/C1+yfGqsQlGILfvEhLtNzgO
 FW6serBk0+ZDC5amt4D1ZV3AzcRjfFVxgMi6c0bKnJ58tC1EOU7UzGyPHLr9w6+/hr8m
 ZogSqrOQeUwSBpMPoMqPZqvYLY5kBpVBQ7jBi4h9H+XrLrID7Lgf8F6amEaMQdKdogXG
 etAMO6eetjT7PPrtIl7BPZ6PuRu54pvobuZu9uu3WxhqLk5uNKegh2rf2smNkMZwR7Oc
 BOqUlhTPYOkekaYiRsK0PZwwfN2PfZhLXo1+sjd7uWMqX+nbMGh6nKDcX7xIyK9uJT52
 EhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787608419; x=1788213219;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YoOc4GSgqsiLx1znxT5qOCAzq/nKrAwxNGMECdp/i0w=;
 b=jp9vvQd79cb9VnjP7pkxVDRkpAl+3VayUiE+3FiwVmC4XSH4QVhQCdCPfv6u6WBaND
 NW+BMKkVg6hoNIhi3qAbUHa7QUJw686hfRdLf2GkBB/Fnsv+nl77bsiv+pBWXieqsmQu
 QxyhZ4WLTrrK4oDdF2lqxHPtMsCbGyn6xdqCFMxkmoei3DEg474Ma/a7HR2J6lXpIyT9
 NEOqd0vQHLlVN9vDdJQpIYqRJ6bmMH/ZPU2QLmD/ZOw4BZv8VQad2amLNQbLJXoZpd9K
 bQ9E2eyddsP/AD+MoTwRqxyrHHtdWpl5QstWZ6AX8S/39UbrqBN0mq3kBZQoqsSTNKlO
 B6PA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMaYTeE1dTd2WBuDv7A4Iyn2tEvDkg7oTE4CCGBpmDfh/Ayut7LndEAPMv0xkVGQVa3f1MyP0iOt3k@nongnu.org
X-Gm-Message-State: AFuF++ldRHpnayDIwdvU2BRs+T/U48d7VFLvxhO+uEXmxJeuDdAUi/6Q
 ptgcmakjukMLCEF+h8jozPHO5pNgjpArPtEEyuRRxkMgeCZ1ZBHqXVolpG2ZAfq7UDrY0ZIJSlx
 cOkF6P/DzZ1WbWQ/Mvn63h9wHK8eAlrEO2Zk21H1HTeWFC8iSM2Bo2Fj46Q==
X-Gm-Gg: AR+sD11YkPqM9Sjmt1qD8K5Lofcccubpm66+SdehPrG6m5B7LTCOCYn6Z4VJhI+hSVO
 aeBqj5j/L9OUXMHMWQiFNipiV11cj9SbGOJsDjm4ejX1inlDKMokzYH6I9ljPU1AxqMYEpUcTPU
 PmUSFyvLC5Eb6qNqiD0xkrYoqBqHzmSe3pyxKh5PkuVZGKn6wf5DdERYiFJ+YBg3XAGh24FrgmW
 uHIeolSrnW45mHYTKUafLMDlNA12+Sr+CVNYhso6xwyA0d+15Dd7aJoshplPFFECB7s7bQW0UKi
 WQjZY13UMkAzii4hp7BWDIz7K/poq74p2gYoOdqjAITQfCtfMs34DVVnj0bBnXjY4aQTLllghPN
 Gq7+omvlCKex6IqL7ZP/Gfa3ufpNipydNSi9nYj/cNxIO8IaHdLMAVLmRqtuTClY+Fe8l
X-Received: by 2002:a17:90b:1e04:b0:396:41d1:cbc7 with SMTP id
 98e67ed59e1d1-396462b8dcamr2947901a91.3.1787608419037; 
 Mon, 24 Aug 2026 14:53:39 -0700 (PDT)
X-Received: by 2002:a17:90b:1e04:b0:396:41d1:cbc7 with SMTP id
 98e67ed59e1d1-396462b8dcamr2947840a91.3.1787608418461; 
 Mon, 24 Aug 2026 14:53:38 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d324b3sm1029786a91.12.2026.08.24.14.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 14:53:37 -0700 (PDT)
Message-ID: <86840ce6-0136-45e9-a04c-95ca2092d21b@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 14:53:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins/lockstep: document plugin logging requirement
To: Dalbir Singh <dalbirrana838@gmail.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org
References: <CAAJFZSZ+2tzVSyfe983Q=d14Xcmu0a3H41-2NdNvv0pDqUViLA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAAJFZSZ+2tzVSyfe983Q=d14Xcmu0a3H41-2NdNvv0pDqUViLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HrB266H1ngHDjyMsfomCOCfUivJuJBFK
X-Authority-Analysis: v=2.4 cv=OLAXGyaB c=1 sm=1 tr=0 ts=6a8cbd63 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=_tSC8qciDedQ-1uW_okA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: HrB266H1ngHDjyMsfomCOCfUivJuJBFK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4NSBTYWx0ZWRfXyKEyKByhLRlC
 vAoD5j0VoX56KMWW1wB15GtyqXAUJBkSxWLbR077y1Gr917MfwE2bph4IsUC3xFBnAZczIJgjBy
 UechHMrkn6ObSb1X05gnpDvGDUKyMe4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4NSBTYWx0ZWRfXwvMgHXuGzer1
 O7il0zZqU+qnflrKXH+6SX3aLQO0bvGikm4Ry+/PwqUvWgCegZfhCfJiXzhfUFJ+8Urk3/fkymj
 +Ipj/aMP96HTEmE/r+ACvFQKk4Zgz7ML9+JpoMZ1zwefyUOeVNx9lj8b+wsx+xaHO33yEaRf1wD
 Ic0SX8s5gSFeVAi0wqYZJPvM7/1ako+uR3+VbzZoTKVJCrskoUvZqQtQqiCktvxIRpE06Sa33f1
 Vw5/lwj62DNtZvipVq9u8VVGQvkPdsmxXW9Z9ybZ5Ku4BCeyUfQKGgD0P18TL85fXO+lZDgt3kx
 CiFLH240klKyQRkR7NjydOpoMfFI8NwgZWBFM4DINF/S3XUHwAzburlkzBefI6fqK7ANefcnbE9
 1UJUlvkavw0vvqN6tzQamORuu9t4WlxddDwGgyS+ZuiWJqbLGSXVMunz4qDnTaslJ9Ie8/P/jhB
 gJpzF4bVrzZCsaTEx5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240185
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Hi Dalbir,

On 8/23/2026 5:31 AM, Dalbir Singh wrote:
> plugins/lockstep: document plugin logging requirement
> 
> qemu_plugin_outs() output from this plugin — including the
> "No divergence :-)" summary and any divergence reports — is routed
> through qemu_log_mask(CPU_LOG_PLUGIN, ...), which is silent unless
> QEMU's own logging is enabled. A user running the plugin exactly as
> shown in this file's own usage will see no output at all and can
> reasonably conclude the plugin is doing nothing.
> 
> Document that -d plugin -D <logfile> is required to see any output.
> 
> Found via manual, reproducible experimentation (deterministic guest
> binary, controlled single-instruction divergence, TB-address and
> instruction-count cross-checked against objdump) with AI (Claude)
> assistance in the investigation; the missing-output behavior and the
> fix were independently verified by hand before this patch was written.
> 
> Signed-off-by: Dalbir <dalbirrana838@gmail.com>
> 
> diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
> index xxxxxxx..xxxxxxx 100644
> --- a/contrib/plugins/lockstep.c
> +++ b/contrib/plugins/lockstep.c
> @@ -7,6 +7,12 @@
>   * introduced a subtle and hard to find bug.
>   *
>   * Caveats:
> + *   - qemu_plugin_outs() output (including "No divergence :-)" and any
> + *     divergence reports) is routed through the plugin log mask, so it is
> + *     silent unless QEMU's own logging is enabled, e.g.:
> + *         -d plugin -D /path/to/logfile
> + *     Without -d plugin, the plugin runs and compares correctly but
> + *     produces no visible output at all.
>   *   - single-threaded linux-user apps only with non-deterministic syscalls
>   *   - no MTTCG enabled system emulation (icount may help)
>   *

it might not be intuitive, nor documented properly, but it's the default
for all plugins we have upstream.

Regards,
Pierrick

