Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE05606D805
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kfQ3D+c0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gyuuk293
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOU12-0000LG-VM; Wed, 04 Nov 2026 00:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xOU0z-0000Km-Pe
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:58:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xOU0y-0006c4-2I
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:58:29 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A40R0hc1191071
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 05:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WoyFrNJLUjxx/BDFg+406K7A1W2kkm/Tk84EGzmvBUQ=; b=kfQ3D+c06J1LwI35
 R5LEZqRSMrWnU3tlVv1RBDkObtXjfzPoZgGyQzN/kXN9K2E8TccLq7CDxPDLBOO8
 Sz5zOMzkIqkELlvsITiHCB3rOa2Q3O9ZQPJ/u1SZ28LSZWA8iI4eOKSoeBvJSx++
 ONC0NEU1O1gH/FCggbtJNXs8mFnUrkrxWyvLzDsG8lM7KdW79Il6brapM5l7VMKx
 nwumlBbq0pgx1hVv5AOyOzBAXRGJYr+9//cZprBU3/SgpF/9tvzL33lw4OCe5dNJ
 Q0NOF0dhOLiNULXxyqpFD4S3pv/q+Y6PX3y2X+I0mTQwGBOXD1iIJqIE5b5WI0vL
 T2Kp/g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pjh0y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:58:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb93c874bso293180885a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 21:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793771903; x=1794376703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WoyFrNJLUjxx/BDFg+406K7A1W2kkm/Tk84EGzmvBUQ=;
 b=Gyuuk293fqImOVwGZmtFPhnIo189Gr9Xu5SPuDEbktDAEPN2REZFItLfNdtzft5r0m
 JLlxrOIKIkV7hRZIXJeRRii2yCylVAbA2W2lrPOqtqfVcC3qGlSFVa3h+fw+1TNhlqzt
 ltSS7duDWNHThMhlxckKpDN8KVjYoh5gEmsjqjFzCMHHeXP+Zi7n6/g3G/R0/exthmB6
 4fAsFoYcooQNzFUCn3Cg8x+dr8hE0II7F3PJGhQFvMGJkz9v8TiZDMvpLMBoTeqynC6s
 BGGqFl1Xsr/yv+md9TI8OnfwxfO/+PwWlgnhyXQ7nCBczOWx2thPii4yjNeDxWrKpHdo
 SiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793771903; x=1794376703;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WoyFrNJLUjxx/BDFg+406K7A1W2kkm/Tk84EGzmvBUQ=;
 b=sce0w+llFAN7nSDlt8Jw/5eBw8Am4JrTyiaFN0DhZsfwpVJzdB64jY2+ztcfFflFtt
 zVFx9/SDceG1iFjJ7xnfQZf7A4KABsndGWKcTwBVl5IpFasMj4HXQiFLd9TWdNwl1Gaw
 IEQgsx44HBGg2Qdsd/IKf4ZHGFuSSEhcIHiRVd7ro3pmE0PtoGzk/W3wcDD7jSlL4rRC
 mPK3eVMydp2l/FWXG4JXa8AQH6khABSJy8M5lm++3vB1zKWtq9HzymVnvNNlg1E3EtCt
 +N0OJe8WS6Jhul7m9Xb7ZXIq+Ogknaowe5nzCnLpqjH8yMCPtVu4hRM27EAl+3B6DJDa
 jNWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZpBG4kLTtO5cgDV/eVwfytuwubk6O1T2Ski+qGKrxv58ixF8DG4mhT1VKGXZjUHQlr5ksz8rnwQiC@nongnu.org
X-Gm-Message-State: APuU4Z+02rDrqm/22I/EYQX46tncGqijp45je0+hwfH2GWxvHWkGHjPE
 WMmQ/k0vbFHRRc3+YjGqgh/uB7sFXqxcert3bIIT6N2c07eWQbvh6SQEtX5cAgDxvrLuNua2kzh
 1MIaF/KZz+WFqE66xMzW0fAFVDH4tw3I2GoZ6eZ1ellx6y9IruvHStI+rWw==
X-Gm-Gg: AYBFou1Jjr/GllkGJlAL0Pq04avHt//gvCrWS9PedCEC6S46mqLfpKSReYAVhpTk1ks
 pA+a1dhZPY2Em48hBc1Vz0ykP06vS0/UQCyNEeIh4FiThiRmBG4kcYvY6bJd4D06P8ojNg7mDSj
 ST3lTcU6PahprydfCb3qfEV4/r3bqcV4QgndHBBVRjA8h0BvpsEJ8f2sMI3UZbemuFZo3xQWD6E
 6OnVnTImU7ImQiozCrwOGDhfobb6ZlsvqmY05LDBpq6xvMOynaLWQPSHXJLqipg735qoZPu4cfi
 UTRlh92gz5OPKdSzB7998JiIIaYcSBllZpSzuX3LI9ywM4jPDL2hfXRZyxFRNv3QJJfP8KBuC7l
 tk26aV8MM7U8A74BuTxizjeK9Px2Mwo3L3pkDTvgmnP/5vl1tkj/m0CdqsmVydCwItXIbP5ko
X-Received: by 2002:a05:620a:2696:b0:93c:65e3:df81 with SMTP id
 af79cd13be357-9441335ea19mr2857800085a.13.1793771902988; 
 Tue, 03 Nov 2026 21:58:22 -0800 (PST)
X-Received: by 2002:a05:620a:2696:b0:93c:65e3:df81 with SMTP id
 af79cd13be357-9441335ea19mr2857799285a.13.1793771902400; 
 Tue, 03 Nov 2026 21:58:22 -0800 (PST)
Received: from [172.20.2.242] ([76.53.41.229])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d479a81asm118146785a.14.2026.11.03.21.58.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 21:58:21 -0800 (PST)
Message-ID: <565c328c-d303-4c61-a21c-7cecd83c021e@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 23:58:19 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] target/hexagon: Misc HLX fixes
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, marco.liebel@oss.qualcomm.com
References: <20261103192358.28589-1-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261103192358.28589-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMyBTYWx0ZWRfXx2Z7QtA2U6+D
 mXQJHhcKM1IEbsuGq4x12YSdrH0PMyZoSgtSB52VadGxZ+R4EG3Q7FHvfI6qvTaAt76eAX8DNuC
 d36z8yTVdS6L14YpFK3HLN710ADq8/fjI0rpuMVmwOyzRd86OiwNL5ehDaHU6m5bb/MM6NAEUUR
 K2VrYHfKO00JkLw8hXvhOeT8jjRC45oxhYD8QsLNQlauLLJJXc4iuFEV0wkzAHNLXm/oTWg4uLl
 VooWIwTZEurOza0pdSU85aoIE9QYfzUJ7/iuvRe/u6NZcka+FyuXzYYHg9KuCgXjvLGM2lteH2r
 7UF4qN4BmFLsfmqXixQ3VOApkA/vXQdGiaGy0gYuWzUrXNVNiHAiMGBG5Q2vIGxg3AfEuJ1FV44
 K1FBGgDwxzIPeUkE+JEinjCMs3/0L5Ljix1JysBSiTgM7Tx9ANZ67nKeh8zIhBDZr2FYO8faB5i
 Z1pkhcaLbd/TXk7q/YA==
X-Proofpoint-GUID: OXvB1XyvlomwttI7Lw37i5OWurjad6BG
X-Proofpoint-ORIG-GUID: OXvB1XyvlomwttI7Lw37i5OWurjad6BG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMyBTYWx0ZWRfX0a2JOqiFUMBJ
 8WhO5kdSB1Zc+/gN3NF3zpjX2J0T+UxYAW0iAu9CJzfjdjPnxhSM44YtYz+mo3WPklfdsxIBxC+
 42EKbUXWKIfQ2Xh2Iu52AyYkc5GmjKU=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aeac980 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C/+e8qdSF1KGZfkfVU3SUA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=H3KWF-iDgBNSfZFRjPsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040023
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,T_SPF_HELO_TEMPERROR,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/3/2026 1:23 PM, Anton Johansson via qemu development wrote:
> Hi,
>
> I was too slow on the review before the series got PRd, so I'll
> submit these preliminary fixes instead.  Not included here is a
> fix for --disable-hexagon-idef-parser being broken with the new
> stub HMX helpers.

Thanks for the fixes!  Traveling part of this week, I will take a look 
at it soon.


>
> Anton Johansson (6):
>    target/hexagon: HLX, preserve scalar :mem_noshuf ordering
>    target/hexagon: HLX, search for .new values in pair high register
>    target/hexagon: Forward return address to HLX load/store helpers
>    linux-user/hexagon: Reset hlx_ctx pointer on cpu clone
>    tests/tcg/hexagon: test HLX scalar :mem_noshuf ordering
>    tests/tcg/hexagon: HLX, test .new on pair high register
>
>   linux-user/hexagon/target_cpu.h     |  1 +
>   target/hexagon/macros.h             | 13 +++++++----
>   target/hexagon/decode.c             | 20 +++++++++++++++--
>   target/hexagon/hlx_helper.c         | 31 +++++++++++++++++--------
>   target/hexagon/translate.c          |  7 +++---
>   tests/tcg/hexagon/hlx_assign_conv.c | 35 +++++++++++++++++++++++++++++
>   tests/tcg/hexagon/hlx_mem.c         | 22 ++++++++++++++++++
>   7 files changed, 111 insertions(+), 18 deletions(-)
>

