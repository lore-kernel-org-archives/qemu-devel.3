Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CA8CD8C88
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 16:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVtaO-0001xY-Aa; Sat, 06 Jun 2026 12:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wVtaL-0001xF-VH
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 12:09:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wVtaJ-0002Vs-3q
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 12:09:20 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656EsSoR1677190
 for <qemu-devel@nongnu.org>; Sat, 6 Jun 2026 16:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WVwFr6iNr3nJbDTOpgOPusav
 iKyW8l75NcPsMN/wwkE=; b=bDEupg5vH22ntHBhK3Vlvp5L1/gopRK6w4fTGiwE
 jbLXv5DUx/2NJVfZjORLrjZZqejoyYUHXAangCAkjd4h7OOLinf2q+hi11Bug5+t
 qi7JEvteb7KV4jKLEKr+HKiwezrdb8CMKG5Vw+k8VwF7S9btC6obvXbt3qmCN1pP
 bLk/6QRqVBn9Mfekt09r/POZZZsmtdB11gV7ZiEStzgPQjE9hS0VYuqrsBp5KOK5
 fdZ/eTQnuFVaX02s0apZYnDBvsj73Ce8FYpJHPjWWBfV/WXb9AQ3i1ILYlWU1mMW
 qNPVnkapCnIy9uY/r2wtDz76lHSQ7ZTcpvg0cMMJyH0ZXw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgsd2g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2026 16:09:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30761ab3483so2875495eec.0
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2026 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780762155; x=1781366955; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WVwFr6iNr3nJbDTOpgOPusaviKyW8l75NcPsMN/wwkE=;
 b=YBfR2yVU21vnIiBIKUzmdOGwrivGlWJ1fFJvaxApjvd5On0xQL3yQXKBdiMnWHUak4
 BcQ+KHTAK3ob/wHXKhFuHJ72c9g91Sv6Qp9LeT8SKOt9JPGin1DZy151MLuprrFdOwJ8
 DsFISTrDD3/hwukJh5fjny2cHtIrvLS3k2Ds1dKWssTxlYW6Vil9e8Am6mKn9sfuHGn/
 MaY3oMVuV5A5Lrz39TkN8pdFwuKqGvE0wTewqesG5TJ+1J1ZclbL3xHYWmCoimDy+P+I
 UDJCmBMQ6as4D8MPETV5PMMJaW4DMCgv4ldeOnCFUP9VV9thumV/mq3ZE0veW0dLSlGh
 RZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780762155; x=1781366955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WVwFr6iNr3nJbDTOpgOPusaviKyW8l75NcPsMN/wwkE=;
 b=RscvE10pWmoKfkStLowl+sdTTXMzD3JHm3/6sJlz8d8qpKUdwD4x6AOOhzBhEpX3fZ
 tDx47QMxCs9xZzgZd72oJWDZrQgii2RjwmsoNmDmozi55gZwrjRxhbnXCsx/38odoRoC
 vJmDsu2Qjqq0bgyEO7fAUCNTL65qV3OYv7v6lZJFeVlvHHa7J1tNGY7l/9nXaHDkuF33
 I8QjR0Xwgo2BzQafuVH+78YgU54+hy6x3q8L1eqKG/KkC4iQRSb6YOeKxKMryTnNQmjy
 owM0iOB+H2NrMc/LEmJSIG9/Vn5z4fGM7VIsI8vTgj7xSpfcQin6dL6Si55UvcF4oH2v
 XFjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1T/QiqlKM6ruXq35AVSaYMQ/VAXeSfkM3ajN/XskilknGWt7bMRhZv9wx+1MidN+bWADupJk6LGCZ@nongnu.org
X-Gm-Message-State: AOJu0YweGxPUqofErqtqlFKqu285mKNmQ3HI4ZtZaoR3xmVfHh4IHQeK
 lBY3uRuY9K2x+iPL5ihYPNaaEBxPByOwcLqMZho7Lbt/uOwVRq4n8zWh3hnzKluey1UgLRCxKW2
 wTCsMmEplS/q606BWCc58EKDZ9++cDi2QOTxy/2TW0fvkeds9S+sun4q8Mw==
X-Gm-Gg: Acq92OE8X+UwfKoGogd1yohNspt50UdnsHyZZB2MukbjwjMQVFVogT24efIk0gkmn7a
 2TWGaJ68wgvKzw7kXWmrQUqq+jwtaUe8/Nr8HS7eEDDpzOUmtvcOM44J5QI9eYWDcuN88eg7ohw
 PmXR7THZMHA680N085UgXb12o2FfjblOgkOpy52aPagY6/Omq3yn74lu8fyc8z36C3EN+VA4xBx
 EaxyvlNc/FA3X2OO0AYK27xxlOPjHfN4YmrFrhB75xuyOxh9H4fAC/NSDQLsJ1znQFuzRG6Z6dm
 3Qtm1uDEoG5tUpJig5bC52sTu/d3o2awjqW04XMJITum5o5/oFc9Ke9C7NFs+XrnRGEiuGZgyJs
 4kmFcvFk6a0n+cdxlsUMms4I8dI/tM7thPbMTW3mS5A==
X-Received: by 2002:a05:7301:578e:b0:304:e6f8:7ccf with SMTP id
 5a478bee46e88-3077b78118bmr5564830eec.27.1780762155462; 
 Sat, 06 Jun 2026 09:09:15 -0700 (PDT)
X-Received: by 2002:a05:7301:578e:b0:304:e6f8:7ccf with SMTP id
 5a478bee46e88-3077b78118bmr5564784eec.27.1780762154340; 
 Sat, 06 Jun 2026 09:09:14 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm13888759eec.8.2026.06.06.09.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 09:09:13 -0700 (PDT)
Date: Sat, 6 Jun 2026 11:09:11 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Icenowy Zheng <uwu@icenowy.me>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v7 2/5] target/riscv: Add server platform reference cpu
Message-ID: <skdkxsqs7ag7el6ikasgpdhc6p2g3zdoqexse2fj2mzhmlybmt@2pxvqsl7ho77>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
 <20260604095244.3313259-3-daniel.barboza@oss.qualcomm.com>
 <4acb210eea217195fa733a4f42369c01591d5499.camel@icenowy.me>
 <a77a1891-214e-4788-8cc3-a5729f5cd182@oss.qualcomm.com>
 <9b05368c-972a-491e-bddb-7e015100eee2@oss.qualcomm.com>
 <5y2sdlx3pu5oyhrm3yxxkvkwv6pl3bpvuzdpnlqg4xt3l2zrxd@yi4h5x2f2xze>
 <3f9d50fb-304c-4ef3-bd63-9fd215b45965@oss.qualcomm.com>
 <17b395009bef17cc056ae4a58a83c744ebb12798.camel@icenowy.me>
 <eb4169a9-6f28-4104-884a-62249f7ccdbd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb4169a9-6f28-4104-884a-62249f7ccdbd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a24462c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=iSatDKZ6tTKaIovgxsEA:9 a=CjuIK1q_8ugA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: ChYnrgxwv73GUajNjL5QbpmNZVg0QGnC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE2NiBTYWx0ZWRfXxA7WsZXHESNS
 96eMTvVPGLZhxPVI88M2HDEyW8TzURfcSfIQTdb5Dn2fti9HjC/vu0y5ae/cIsttki1S708dMmY
 ielhicb+bqXfDWPtZh0PtHEh0nd9AWaPVhfB1WqAD/568Jw4oY3TOMjJ6Zhq0seeDiqfUEMZHV/
 xf5BrGjvA5oOYaHLHB+e6nGirWLdKwGXX/4eaNiozCysfSfkCsI0fezVcfFCp9Wi0AuIGte7U7Y
 rZO9qKBrW0N47QoRnnmD+VWpiFj1mR74TRDElI/R6NFV5zqNMRof66yArdCmy5nZbzvjAOGJICE
 0aQR1rozW4ltZiGOhPJNCZfWnDWFzFsuh2afWDib/t4khVgAQ3q51pyZhqp98qUYlDDTXBRvYi5
 aC/C75xshwUHN4OfgTkzk/Q2q+DCBQWOZmunuEAKD3Nzr0NvGdYHyEtIM8qjh5I4NhiJsgUsv4r
 cKiN2feigv1tooSafeQ==
X-Proofpoint-ORIG-GUID: ChYnrgxwv73GUajNjL5QbpmNZVg0QGnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060166
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Sat, Jun 06, 2026 at 07:21:32AM -0300, Daniel Henrique Barboza wrote:
...
> > I think we can just make RVSP a profile, and rvsp-ref CPU a BARE CPU
> > based on that profile; then set the profile's min SATP to Sv48, and the
> > BARE CPU's max SATP to Sv57.
> > 
> > In this case if any other CPU complying to RVSP is added, it can just
> > reuse the profile.
> 
> Having riscv-server-ref being a profile CPU seems compelling indeed ...
> new CPUs could instance it with .profile = &rvserver-ref to have everything
> already sorted out, we would also have a flag to enable the profile for
> existing cpus, e.g. -cpu rv64,rvserver-ref=on.
> 
> Drew, any thoughts?

As long as the concept of 'profile' is internal to QEMU and we comment its
[ab]use explaining why the riscv-server-ref is modeled that way, then that
sounds good to me. If the concept is exposed to users then I fear we'd
confuse things by inventing profiles that don't exist in the profiles
spec.

Thanks,
drew

