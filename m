Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3888BCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZKJC-0002Dq-12; Mon, 15 Jun 2026 23:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZKIo-00027D-Vv
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:17:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZKIm-0002i2-9t
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:17:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xmFn1790644
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aQ+dMyvU4iUezytiPYhDCe/rLT7Zqzrs6Ane441KsWs=; b=a27HFR/Ebi5Oypql
 5jd6gkChc69uhdE88sUoWUJK8yPfTlBZL69Du0C68yUxuBXH5g2bLwlv3tHzH8wp
 J1L5VhyN8W4mOsDybaRpKIG8qfazG79U++aZQOTRK15gAMqgukJYVmlwuUrE4Cx3
 EKLdLqFHt/vn0VsTyyhkffBbwPWcKz/5kdI0muPklewSuaRO6ZBvaU9/WY/QyRsD
 xY68KKZiTtyR4AKhZLAGRIqnfFFIRet1OoQ+g93tepoV4CYDvWDO9Y5yoH+pZtc+
 6B9Aj+azUyZfaxnP+nb7ElwDkmb9fkObsRfsdFGr3nv/tubw3DNCFdhm6mCpPxOt
 EBKqtQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0mfbh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:17:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91931144870so465380685a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781579841; x=1782184641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aQ+dMyvU4iUezytiPYhDCe/rLT7Zqzrs6Ane441KsWs=;
 b=DQwF+oJ6TcougZBWY1Mys4b7cI5UDW02jVhcUGrxUlH6Bo+COJcC//bMgpzRoKGAO5
 3WPIuA8qM432EOvrihmWJsXQQYJJuIqpEJ1pNGJP6IMNVWJZHl3XfDmrTrSWA7TXFKsQ
 bD/ww9SLNURTogQPIXDAZ8evzVRbsdga4pkO9CP6Tbh3bCDw6wlSphu40SbcT1whMjnC
 gBtwKTPQKyKHYvw6YvLPJTk+0UWJZZ9F5+FGuGl9G4YJ/em+NvdrtGctlqXf3Dtfyx5X
 ev3T1Vdoz/Yqa0ppYs0ijE70XOLeDFBxNBSKQJH0aV0Cv/QRsafBb9/Ti564jsoGTs2d
 1D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781579841; x=1782184641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aQ+dMyvU4iUezytiPYhDCe/rLT7Zqzrs6Ane441KsWs=;
 b=YOMf0fR2VeXu4xrLTsjW77JIWJl2g2PQ+wvB4kopGAChqMnyctGxmgWEJhrVQv4oFg
 I8I/eb/gJgVI59R+NFw7fq3O2OeFyreXk6mdmYartHItdxiaeG9MMaV5WKfTikDWIseh
 ZBFOHA+fKLW4aBK/Z2J7Cq0uciQCDI9ByQQs7cYsW6HWPU3y/LN/uWLH7Q/xjlpDR/ZA
 cm9wgPKSWCXt9KOGrJ5myudrDu+uiRoHdFaS8WIt+ky5sfDPT230f3i3OTSiYNQEx/6A
 XhFjmUpXP2BoUiE63Mb4+sykgM0GuoqO1KTHJPW7bGFOXdDA+Ha2slCeW9KyGLPcCqiF
 8b8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jjO9QhqKCZYF9gEaP3q7LuKnKAhKHMgMz8VTwk0naAO3PLmskDETZUVV3XMWHAul+nxWnxwmCzDHx@nongnu.org
X-Gm-Message-State: AOJu0Yw0tTDDg4nytZngea5DL94JDUZ9KM0OHnRQHZSxbfv6vgnFTTbO
 9QagSSJkkwIUUyTFHkwVW2pg7jKUz1wh6QnCfqKc01t41rvxH2iF8rmrv8BOEhkfpwilCg9tp0Y
 xpfC8c2qhJwLDo0NPz3UE3i5w5rhKsEIkHHRY1sANoF30Bw8TsQuD/3F8lg==
X-Gm-Gg: Acq92OFmeLcP+BxXceyegrrkN2g8X04wTalv9uQCfIDmApg3C4zTivDpvJ/ehbp4UuS
 qnn2d0Yqf05jgkFcljy4mIBe2x/O9lZz/hMLibkLEUKrJGOeDvohgnwwKvhWHPYxOpa5QAshZ9T
 ey0jv8M4ax+TiujtoouXvpLe9i+ktnrtA/ySE7/9noyaSFdqS+DACxo2wQ/AEkQsXQ48mpAYp1C
 L826v44FgDDuDR6QCn39EX6qmqwmCz8mMP6sE3GdiAQ7lCtVBL7dhmB7JCndI8d9CdbHLd8etiM
 BPwCkOIbqrFNHyjnOOigDaeo2LH768o8qPtFUd/V7h0ivsk9MXzaQZvURpC1O+4r3JsLknTCDUf
 3zIm8GbRqq+Ym6KXWMx98gmndxll46frvJT88p8NA9qmQetsgmqjzDNh+tg3aS23487dImkx8
X-Received: by 2002:a05:620a:2b93:b0:916:1a02:1965 with SMTP id
 af79cd13be357-9161bd4f753mr2548772385a.50.1781579840942; 
 Mon, 15 Jun 2026 20:17:20 -0700 (PDT)
X-Received: by 2002:a05:620a:2b93:b0:916:1a02:1965 with SMTP id
 af79cd13be357-9161bd4f753mr2548768285a.50.1781579840411; 
 Mon, 15 Jun 2026 20:17:20 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea963cf8sm234101855e9.2.2026.06.15.20.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 20:17:19 -0700 (PDT)
Message-ID: <ac9208fc-90b3-40d8-938f-24ddf93325ec@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 05:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] igb: Implement TRL register write and configuration
Content-Language: en-US
To: Josh Hilke <jrhilke@google.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
 <20260615-igb-trl-v4-3-cf5739bf529f@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615-igb-trl-v4-3-cf5739bf529f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAyOSBTYWx0ZWRfX9nX2xtgvXnUb
 MyHgZC5qc3KhkuahtZ1gsa2aoHuLIq0H6H+DdGDINVX8EaaN37d9/yqTD7MF+9tVmo6s4E/+Yj5
 gnuXe5/u1LS9kwk1jg9diO9DCDGfFXQ=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a30c042 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=1XWaLZrsAAAA:8 a=HF4FIjVPIHG9C6RmBfsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAyOSBTYWx0ZWRfX9rmAJyIMN7dK
 pUXZ95rijT3DVT1+cr/OyzInXLK5VyJJF01fq8L1IrKYZCLpfP4IyUxicqi6G1OpDnT0d44+D0f
 JRAbZDEHzTgBw81AosLJ7TZbBP3RTgywcVxq9P9tzTmZuZI4B4fUsnkB0uryxMXsAMLWCRiEQUw
 AM6u5kPJOF9iy/Yza9GAgwLb8KIw2u19JYZDTk9K9HtjoT45TVxYWz5lLAgA3sPj5igPcgFgXXn
 sFjjDFFzsp7RXCPyA7Ioq3i3HBaSdo0uaUAk6zZeTLdKtvOWTrO6Gv5np/1GawJtEzc5yvAMYfe
 8a3eN/Kr6g7NAfTHpujECxNqRm5nuNJuLUyC6LhNe1Hj0oh39dG6RrUysw20T/M/okSW0qVJoVP
 HirxtC+2KvhPl2nc3/8IOO9o2uNyD5sbXsdcBaIIwNSh8/2HsLi/WBV1YQvdHtCTRhRsdrzhJTF
 YSTjnACD9EIr/vwyhXg==
X-Proofpoint-GUID: ZyrRc2QaI4Z_L2FkKm4XWO3K_63jDQ-l
X-Proofpoint-ORIG-GUID: ZyrRc2QaI4Z_L2FkKm4XWO3K_63jDQ-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160029
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

On 16/6/26 00:18, Josh Hilke wrote:
> Implement write handlers for TLDQSEL and TRLRC registers to allow the
> guest to configure Transmit Rate Limiting. Translate the register Rate
> Factor into a physical target rate (bytes/sec) per queue.  Disable TRL
> and clear timers when the link status changes or when TRL is disabled by
> the guest.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_core.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 56 insertions(+), 1 deletion(-)


> @@ -4127,7 +4180,9 @@ static const writeops igb_macreg_writeops[] = {
>       [PVTEICR6] = igb_set_vteicr,
>       [PVTEICR7] = igb_set_vteicr,
>       [VTIVAR ... VTIVAR + 7] = igb_set_vtivar,
> -    [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_writereg
> +    [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_writereg,
> +    [TRLDQSEL] = igb_set_trldqsel,
> +    [TRLRC]    = igb_set_trlrc

Please add a trailing comma to avoid the same code churn in
the future ;)

>   };
>   enum { IGB_NWRITEOPS = ARRAY_SIZE(igb_macreg_writeops) };
>   
> 


