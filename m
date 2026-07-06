Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D361EC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgdDS-0006L2-6U; Mon, 06 Jul 2026 02:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdDK-0006Jx-IV
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:53:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdDH-0000v4-Ds
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:53:58 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641Yt03402255
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 06:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1EalhcY6j4I0vdXAunMckmj897Da1M2g1TBvLUNLDJs=; b=DmJQ3uPd0h9vk70O
 J7/X4zRbGf8CCjXrKiyFtzea3Gcnkazt0GcU6RgSBYE5pai73zrshqqpeozC/+J7
 /CzJEsXte9h1gruTwEr7DkkMjuU8UHuUEddlFPFrWKiNpv7xsOajK5rNds9XLb19
 nXRRkK4sy2wSirL4wHJ3n4Z1W2sQfJcWipeNSMTX9thFXPKP2GqFGrCk8aWyfGMi
 0Pn1JzFkNVsoiHGE18mygHXeOb8RKb9JzrWYJDcmL84WtnV9Jv1Zjco/pEjfbB6a
 HAc2vi5s9ZgWtAgtLiIJtLhUlokidLotSQHkXkcHnDiyleLD7jpGFeKrTggBHLwH
 01X1Tw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ubgmrcv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:53:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92d1cae5740so292836885a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 23:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783320830; x=1783925630; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1EalhcY6j4I0vdXAunMckmj897Da1M2g1TBvLUNLDJs=;
 b=Upd3lTOQTZhHiuitJ7pL1q8+4r9o5AGhonXkscrlPerWGRodjKF6yWIvNdoU68BlCd
 6SJLWRDxQPc9jxoFS53mXvDwbzkiyHGRtxxx2hIctu5YNGjUwbYYM2tuClEwZQflD07+
 oN73MLv5ZUxE9ARz4twd1ld6+mqC8kt73aCaTxBBaZ8liuBDkFm5VX7mIt9EvS1ald+a
 xaMTsPoB9GEMcYWJL94WOD6FwzkphgYUQSkEo5A2njZgIo1WXU1YcVW4gDSZXmCfHHa0
 /z7SZzUS7gNnfOGld4c2aElCsCxW/fLcGRssVCY5DjlakaSU+E07zWUQX/emF0jvedlp
 PXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783320830; x=1783925630;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1EalhcY6j4I0vdXAunMckmj897Da1M2g1TBvLUNLDJs=;
 b=EbjXaHrtGNA8kLaYfn11XRhDiE7gpeqmPU+0epRQeInEaQeQzNam/h+UTZrv+We2Ev
 WfBy17FdOXD+3yyljliCxSev4QUHYMb1PKHhvqyrrpJDdvng/Hc5Ii4WHJudkl7PMoQz
 xzVNqRrLfLP9jacxI3jz3YYwLVHC6uVHO55ekGYnxEhBOUquwQ2LL23OdO2eNToPW8sX
 SAUzLV3ihuPRELAQa76m2oyOuqKKI6FREY1sIEplL3qBS+ggPQULnvlDlIOHLbM4X2M2
 11PiqP+w2DoLEWk1O+nwf3OZqIbAQS+7ayaqz0pcWBAgacsJSTaHghFRj/vWiN71lbl5
 HZcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBgj6jnpkbKQGh719BG9/hmnwMkTacbDci6DtIGx0SmzXjgdwcw5lSe+ZH6vgcMPgRu3pES8EpB9wf@nongnu.org
X-Gm-Message-State: AOJu0YwVV56IY0pCxm0ddesoU+XdhAJx21vf1UL/hNwN57xICe/AguS/
 evx1+iMoGa/F7dnMAk9bX9kbC14EdmY1nVRMasfbx8c09axnGYp8jB3hoCMRsK/DelN2lAsU6iv
 OsmyqIRfZ/bNbgAtE04iV2/+6D0tMMzoydpIFkq2uHTEIoVU2xkcQsqV4lQ==
X-Gm-Gg: AfdE7cn2Uu0ZLuiLWt9HmCfeF181cmMQznroRIJRgyorSdjA4ZoSq02Oxealx6AKgf1
 Fwfw5wbtvZ9TRqlIv8JCNGmMm1YDoKwX4wjvzryor0+W/KAIoQFynZRwkMbSNayCG09yN6SX1xd
 NCAlWMCiRawATzuE7lrZdcQLfLROBlcXCJ9o3pxJrU39TAl5Z4r/qk76G8I1+FzekYFZkIGU4hR
 MO98ovVhYZHt18y1IUzQFyPG7sFfupGpbnaCpGFVmvSa5mqqbxi2dGZ2AfAU0r49oe+H6la/j0O
 JMwCTZQ571/ok+gmmecaIKUUcpNAy5wz2fx7o8WyBNQavjyJ9+Fjfm0gL3gTI05m5cyU9DnYDxt
 q5SRKGIKQy9BTEKYXX2qzW3DS1MaK3XqXQPh6O2vi5+YPl+EEmMZiC50Vo0OsEw==
X-Received: by 2002:a05:620a:410a:b0:92e:81c8:3629 with SMTP id
 af79cd13be357-92e9a346787mr1166410585a.4.1783320830013; 
 Sun, 05 Jul 2026 23:53:50 -0700 (PDT)
X-Received: by 2002:a05:620a:410a:b0:92e:81c8:3629 with SMTP id
 af79cd13be357-92e9a346787mr1166409785a.4.1783320829550; 
 Sun, 05 Jul 2026 23:53:49 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960816sm21212740f8f.29.2026.07.05.23.53.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 23:53:48 -0700 (PDT)
Message-ID: <c68b39aa-8665-49ce-87dd-f7b11ad4062f@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 08:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/7] tests/functional/riscv64: add riscv-server-ref TPM
 selftest
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 uwu@icenowy.me, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-7-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610214133.1882563-7-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA2NyBTYWx0ZWRfX50VjNa0GFwwB
 FgG2JAVwSUFexiV7xqpgg3j9AinnOIX4cBmNxuKo1q6gmJgI8tjkuuDfkD4codt38TccYpZHvN0
 ga3c2bne0fVT0OG+pWwRQfIEhLYsaZI=
X-Proofpoint-ORIG-GUID: 3H2Oi9UeXDCe4ESaoFHuJKPKOB7-nLK5
X-Proofpoint-GUID: 3H2Oi9UeXDCe4ESaoFHuJKPKOB7-nLK5
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a4b50ff cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=W-gq5_wEYG594S83u0oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA2NyBTYWx0ZWRfX8M+qjNT26FzD
 Qk00m//bv5qMBHQ4TtgwCBIAzzYlNgrfiEka2+GND2rdXJD4aBoxbrIFM/yFD8B/7d83xUVZ42q
 AVmtlw1QIYsn9kdQ09jXxIY/YxuzCjp4qTYAUf0aqt5J6S9DVlK44dMMyAmDwTtpS8vyaM49lI+
 y+iSZail1wQX1T4N8ZkJRuMB34GYITEdp+WDW/yR0EuIN6duzCYjOOaQw9Xv1rSsMR0nbVla/qT
 ah7YHHjw5C/9G9njJjHdwZr5o5T9s5TUJngvkSvQnOvvc9oQjNSwrKEEWpemfZzOqvz0fOeWT5p
 MWb1z15qXcezuGFiztHllSEKpgre8+xD81I9TpC6lOE494tokaVRP707SLCPNUey7vAt2aRd5hU
 GTPAzhq1LQIJmcmbsJnw2kOpCDcIFzgyBHXrEK1vSvYKncOAGT61a53X50n+bInOFkduT2iZg4c
 3Ev+txwd4+/Nc5U3EWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060067
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

On 10/6/26 23:41, Daniel Henrique Barboza wrote:
> Add a TPM specific selftest for the riscv-server-ref board.  The test
> will be skipped if there's no 'swtpm' in the host.
> 
> The test has been basically cloned from our Aspeed ast2600 friends.
> Shoutout to monsieur Cédric Le Goater for the code.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   tests/functional/riscv64/test_server_ref.py | 31 ++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)


>   class RiscvServerRefTest(QemuSystemTest):
>       """
> @@ -26,7 +31,7 @@ class RiscvServerRefTest(QemuSystemTest):
>            'master/riscv/images/virt64/buildroot/rootfs.ext2'),
>           'f00bb88749f945d80675540a1338bd1ccb226574685a5b6c65ab44027d0411a8')
>   
> -    def test_boot_linux_test(self):
> +    def _test_boot_linux_test(self, tpmstate_dir=None):

If v9, do_test_boot_linux_test().

