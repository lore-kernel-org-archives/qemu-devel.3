Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7CACA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGaLe-0002wV-6U; Tue, 13 Oct 2026 07:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGaLU-0002si-Cj
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:07:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGaLR-0000ld-Ob
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:06:59 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D6ZUTL3210078
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 11:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 95UByHkw+0BP+P86uKrKF33ytXy5Wg+6bBpWzLbSzr4=; b=aJVYaZb3YZCbJpJy
 l5zWJItaJI5MKSoZ2g+CV9VHuIZ75ee3MXkCdgGOuINRSF3yJRvNBKCP59n4H41d
 nP7Fvm87pIkO/0zL0QlQhwQR4f/8HXaf051SRvrGQVGaIhLkoSArVezxx4CMs58e
 gOgSkm0tOVFSwhKWj/mfrZcdhe9TCn7jUH57rP8cQvMYGGiS1qS1KKMlIQl/pJa3
 N3jtORsbfCDgr0/cw8TCWJeXSs4MyeQAckC/9Vd+8CVOjmcKjjfWOKcMvv844VgF
 58dcld0+lEnKXQ2o2b1ddn3aNmBhy03ydbyYhlLNcveE6aHgZqNtAhvzkr6j5Bmr
 mfb6Bg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9fgjh4a5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 11:06:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cbf2fd504so493316785a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791889615; x=1792494415; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=95UByHkw+0BP+P86uKrKF33ytXy5Wg+6bBpWzLbSzr4=;
 b=c35zQ6hOEyS7fV7yCnHcyvwqion8fthvACwQoCOLgUYGG/SYGBDgK8ihl3mcjbVyOz
 GLqBFx8/kCFNwtF/ySWjF9TSuHO9j+hXvcfOa4UzsnWuWS5lYPMEHgUGfyLvxFXznLlX
 ol/PjB6yO8oKvp6bUqE0fx4m63tZ6nwHz3KPhZMgDB/ATp9HGxnIdkJnGnlr8WVdBhwW
 Awlbf3tTEGj5Kt2rtAfeokSn55sgCDywxphrDlx20aM7aJEGY/nuhqamgWTeg0LJ/uKi
 3ZGtp0+oXyFPwE8oJLUGUs2qBrB1KXwmyunHDW6IqgSK1OHVzbY+ESlYwkvdvFWhTEf2
 /UMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791889615; x=1792494415;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=95UByHkw+0BP+P86uKrKF33ytXy5Wg+6bBpWzLbSzr4=;
 b=J+f71alinrOrlDDFGP8tiKtsJg+qVJuAbBTaPyb1UMavoogl2S4x0yLF++QDBK/duc
 ojln9hNbTOT6YezbeRelmWeKTtEpPFRdFOA+EeXbUeLYxQZh8F2vUKn1mfyr8CrVJ7wq
 YQuU2Bb/ydq43Nr+Urq1MjY1zEEXiCa36tvUMS5XfgYq2O94WpYiBDY0d6nnzXLbWT05
 l6GuWVj8I4s+hoQuS+TpVqf8Kww0E/YPVs2HRxE7Rod1deODQoq+i1xCkIkn+VETacLt
 9Rm/qsWT1U/mcpOg6vJANMR+W64HzNQvedaCircCdD7B5XpS7EFZzz/6JFUYakE66Uej
 uKnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpWNRx6FRKuv3QPSKrMnhlLyDPWyCf0JAE8F7uElgsKAZS9pYp1DXZsiowYdjeH7hpzdtxW22+BkSq@nongnu.org
X-Gm-Message-State: AFq9FYK08rVQfU3YKjyGxXpNK8osrfdWS9VFRUO8SrLHOTt05Z1y4D74
 gwmS7dNoK12Q9K+AsDhDgbZQ18Lo/o/F0Q+OlEU5cOraQgknDy4KC/d+sJ2WClZN6GEftkvXBtb
 vUOESFNyOx+6eIYHkDZGxRJw0zWcmGG8VYlL4B/WIoG+9oUYm6LI7a9gqeQ==
X-Gm-Gg: AYBFou3seVkviALNacJTDz/VFKj/Aeeqg8smfOzB+jodYX1a+yC7g0uTePs35Zm0Qvc
 pm8ZtMf65+25cM9f1zn6myjtWIpXcfHbBXA+GiBI4xz3jmMTyYz/9gQTPTjmpvwFpJvyXjxhTTl
 3YfesPzMlOobRQ0MB0+eRO7p5nP7dgxIUUsY+1YQBWpVeu2C9h0TfDdc9ZUdYFNjmaAYt6PfUkH
 uWesuTztbeu760dSlHECaf9AALQF49aUiH7VuEGhaZfApaZw8CSuJuvFoP2H0y+DzaPwGLcybZR
 fdIEQSwnB17nkHG1x9JprQxbRTN9srA4Winf/U+RvXS9ua1ldmHCHrC4OZGbvRKncy3Qg87G+Nq
 9fQ11pAxX3o/+v2TUY/eAjlzUO0kyHNwLsw==
X-Received: by 2002:a05:620a:2949:b0:93e:c12c:4409 with SMTP id
 af79cd13be357-93ec12c4a64mr1866843385a.69.1791889615152; 
 Tue, 13 Oct 2026 04:06:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2949:b0:93e:c12c:4409 with SMTP id
 af79cd13be357-93ec12c4a64mr1866839385a.69.1791889614707; 
 Tue, 13 Oct 2026 04:06:54 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ec6sm4359226f8f.48.2026.10.13.04.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 04:06:51 -0700 (PDT)
Message-ID: <eb8bb3bd-660b-455e-a981-0c4052d2b81e@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 13:06:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/tcg/gicv5-cpuif: Fix typo in
 ICC_PPI_SPENDR1_EL1 name
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261013105704.1071427-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261013105704.1071427-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CDbnVE9C_77FCcafakKRwylunJU2sA9f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NCBTYWx0ZWRfXzVe0s1+vPbD3
 HXo10AGgbSd6PDyoARBrFsaE0uDLHWfgrU1h/RKBItt3y+w2OCKfggY8Fjm4NNFL9NuAX6fdBca
 t4lEgGgAJocLD912a6bB1bCxZ5XSft2mHLV6QesuyXcgHTfQ++tya+H7n9C6vlY+RzXb/NqjWEV
 3N9YrkoVl+LuUHfQkhClDYlr0HfaBbsss1MscVd/GnGmh2eA20pz8bn+eBTFNIbsJuUT41jMKvs
 SPNa9y2UijzfqgJHW5drNeQUwU/RQjnQTFgbw06n5MQIP+gSoyG8NiBKHKEdpbDZagS/x9wzUuP
 EEf9g2JhTTVLxciZzVbw3naL/XHd3+RvxiRV/et/8pUyMifzYLWKIjqx2E7yV3WXhpENQcjFR/6
 HrGPaF/rbBHnchuUO3of+GlXvhT4QAMdoWOQ2BdfytItz9Fm0MvBLeOF9o4xIM5xPqOKvKwsc01
 lgycc4DTW4+jVXYbI1Q==
X-Proofpoint-ORIG-GUID: CDbnVE9C_77FCcafakKRwylunJU2sA9f
X-Authority-Analysis: v=2.4 cv=PedqFShd c=1 sm=1 tr=0 ts=6ace10d0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=SR6j1nv5fr4d5LppKAYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NCBTYWx0ZWRfX/2BltQY7vRv/
 GQJSB7gKdjO164o0wUOMB73Hfo93fzB+uvvgiu2di65MjbW0XDl3HK6nM2uLgoGmKqOdFR2aiYY
 45iA8qLHf2wbnq6XPmfW64Evpoon9Sg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130044
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

On 13/10/26 12:57, Peter Maydell wrote:
> A cut-and-paste error meant that the cpreg for ICC_PPI_SPENDR1_EL1
> incorrectly named it SPENDR0; as these regs aren't exposed to gdb the
> string here is for debug only, so this has no visible consquences,
> but it's confusing.  Fix the error.
> 
> Fixes: 585dad9e79e1 ("target/arm: GICv5 cpuif: Implement PPI pending status registers")
> Reported-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/gicv5-cpuif.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Thanks!

