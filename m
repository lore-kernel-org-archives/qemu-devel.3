Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296F3C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzd1c-0002s4-0D; Thu, 27 Aug 2026 12:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzd1Z-0002qL-1e
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:32:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzd1X-0003sP-4o
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:32:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RGIftl708588
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 16:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PpzExICWWXrFjUHddg2HT7F1Pum8dEAU0sEI0oHCL/0=; b=QW/J1MND39Z7jPuZ
 7L5JmwrWsOLRlfIG7pctAjsp3NypqJMgVDvThXdYvSKrO/GnQa1pxlE07axUJ/mQ
 d9vIOR1w0WxQoFfDMpyBEtjCIsJoCaebw4MdYJ+jPt3Nfghx1/odBFs/axTAMudG
 sKgXZen1YqnmL485pQAqEfp0TOrGGaVagw3zilcYgIEEceZba5NwL4h2vexcQ3hD
 ra+1GyiXatYyEckc44rFB9jgyEEieLTB23FW8XYXWA2PY16kPviCO1NAl7NiFjD4
 vZygO457zWJvTNs5jtxeIzuSJKx5ahhKJFyRmwya1ognxVkcOZLmx2W5pDuM+8rk
 JJtmig==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0g1wk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 16:32:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1c057f480so95293a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787848336; x=1788453136; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PpzExICWWXrFjUHddg2HT7F1Pum8dEAU0sEI0oHCL/0=;
 b=TNWQasZ4zFLznRpOUv2jozSbGByHDIhoyXG49cochl7TqyBDrkwFu+IUy+Mdte21Cq
 UEdpH3BxqORr8QTjZWKBH+C72a5d4RxtbWgR8+MVS0gwpRsweKHGqN+tzxrLLquH8GBi
 fhsPc7Frx5w/QdacIEYMhiMXy0MUijUb4xl6CErShlbzRM+egMXo2hbb58XOu2RCjRqb
 +9JkGqLDKdkYj+Wwe9qp6EMmHIRfwC1X/jfth8lSdlIXMNyNkytWy0waJTFej5XNabWt
 yJ/ndkwefKXwTbA4Wq21EsQbR2fAPWO0H6EcfAg0TgloNr3gkY9I1umaIqHvCjBvZurg
 O95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787848336; x=1788453136;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PpzExICWWXrFjUHddg2HT7F1Pum8dEAU0sEI0oHCL/0=;
 b=EZMDrD2+PAPm/WBNtIQyimQDoNNUXrC8XroKY59HrzACEJwll/VDMgH6xh2gd1vhAB
 c07o9FWORv+mF9EpG7yKFnf7LQl2pQbfVm29LxyhCNhdbYgz0u7+SdoMxX9jE9f5Fxoo
 5Ihman1NIhRXTH++MraGWYgJZ9mvLt4kRQa3Soum+TTTystgWrOy0x9AM07rcXdlyhNe
 U+sAM6cdLVVhgZ32xwniUDLAdt4RlURkZi6r+CjBPk2a5UUMpEVUuCVdtojFxRlid6ZU
 lBMtftccJ2wmIxQwzQAHCAYC6mTG8PlJWEfxbmVDQ47T33kySUpsNejOi8FC3uX98TLK
 cpHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcA3jHgnLusXC0bIGtMbP6d1SjbOfZgDCtLLj7AenEkfuRr8aZEZpbxg2M2E3a+nyxIaBR+moDOmjG@nongnu.org
X-Gm-Message-State: AFuF++lczJO34INGlT0HjhwmQ79OalG6gc9CcliclpVlOQMhk2uCkRc+
 vDoiNCkVg+N2i5A3D+09U0q5hLZI4uDsvW89RUEZ/Ah9xwuZhj2IyNitmKdVTGzCGXY6yJZij5C
 r6TZciCoxL3R+xYnGqcU4GTN+UIgGh+CjRPfWrkuOWXT2wX9SVXmdLHF1Cg==
X-Gm-Gg: AR+sD13dmIk3X2H8bScXmQTmhVhIbuOP9TpTx2kkRjbAvbUUKpmXbYw1TiSDHEH+AY7
 paIDIrN8oYCzyhBsNQDMmjKfFO6gSbxlB1qLvq4aS5rTIx89EBDSk2Rck3I9n+XqikdHmSVc4AZ
 sszPRrAAa1i+9WFjtBw9FQAFBzDLXU4zJ5lTtR1T+EicpLZ9tLi4um1Ibwt3i5huoe/fPEeUxk5
 jBpGnTcOok/d46aApAvB4/k1J6zZV6JSOZ2tL5+b26eQUGJ8sT7spASSXBXyw0o5S7omvr2bqsd
 mVKO13ZVxxZg4bFTs+rSCFtm3NmVJMEFjNk3bpqHok8Edo06Mvt3JKVslo9JGy0MiPhzh7l40z8
 L1+0gu3qLlEdVhcxqRmB62xcEpXmJaqRuYoxL1ZSq9o8GwtYaRhgquoNzTSUBgFfOIBmA
X-Received: by 2002:a17:90b:3c08:b0:38e:485c:ebd3 with SMTP id
 98e67ed59e1d1-396d0f9ad1fmr754132a91.15.1787848336229; 
 Thu, 27 Aug 2026 09:32:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3c08:b0:38e:485c:ebd3 with SMTP id
 98e67ed59e1d1-396d0f9ad1fmr753963a91.15.1787848335612; 
 Thu, 27 Aug 2026 09:32:15 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a9035ff1sm16751413c88.11.2026.08.27.09.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 09:32:14 -0700 (PDT)
Message-ID: <9e36f8a0-5363-4ce2-accf-62ccf3602344@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 09:32:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
 <b2b1d77e-c3e3-4aad-87d2-f5d4834abd1a@oss.qualcomm.com>
 <apAG8JQTnQxRkfip@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <apAG8JQTnQxRkfip@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzOSBTYWx0ZWRfX24Kpq914aby3
 LB1vt0sFihL/k/3lijsRG1JAxOCYcYooAxqyV048Ad+2lXvgbf1GVzUfbqnKFRBU0Z+UPWVoWKw
 jxq7fhXvPPSeGQIrCqWMe0tC6YZPc+46cwc6pXYjbSDkusnRf7YYzyBGsPd3Gc8QnT0/9P5/k5+
 q1s5SHWt2Il1pLo6B0iqI0OrmBbHiwLKfkzvGrfjJce81mleN5COca1CoiMKzQnx0QdUwDPxD3P
 k4fKKV0axHIbMTdw8o+9ubKnyOARkrall9h8xjTw5LUEdWjlM296zxPP87PmtwtxLyagXNTfunw
 ytiVfSmmnXyhnWkk47fPObQ/nat2vfilMQ6wPkiAUZ3Tzq1kR4cwA1DcOlua2J546UAlYHtf5Ic
 7H4wSaGqMahu/lZZQEEBW32eFYGUMCTYxBL3FWRWXw60mQr7/oir7LXeXp3YB7rSZpWCBhEQ8GO
 OY7T9+ebYpMqej0T/SA==
X-Proofpoint-GUID: G76vgR_qM-a5UbDzDx1vqQnphQXgetjy
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a906691 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=PWUnpSKA2arHrWdFqVoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: G76vgR_qM-a5UbDzDx1vqQnphQXgetjy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzOSBTYWx0ZWRfXz/BgPZ75S38/
 hDTtvt/u4Am/gU+JfD7LCodX5tpqdBGCqUKt+ssPiJdCb36VWiXIUuuZaIGdBHvEsy6qilFJ3+c
 jpLDZOmyTl3hsTaPKhYBaFatoSsY9b4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270139
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 8/27/2026 2:44 AM, Daniel P. Berrangé wrote:
> On Wed, Aug 26, 2026 at 11:35:11AM -0700, Pierrick Bouvier wrote:
>> Seems like the Genius.Artist. in the bottle just need to escape, and you
>> can send us a nice series doing all this. Meanwhile, I'll try to find a
>> carpet, a monkey, a princess and a suit to be the next Aladdin.
> 
> This kind of comment is not productive and disrepectful to the time
> reviewers in invest in looking at the proposed patches. Please stop
> this.
>

The only person wasting everyone's time here is YOU.
There is not a single person who came on any thread to say "I agree with
you Daniel", while several posted or commented they were ok with the
approach here.

Project is QEMU, not Daniel's EMU.

Whether or not you like my joke above does not matter, just focus on the
first sentence of it. Send a series implementing your view instead of
long emails "I said so" on other people series. And go back to the lamp
until it's ready.

> With regards,
> Daniel

Regards,
Pierrick

