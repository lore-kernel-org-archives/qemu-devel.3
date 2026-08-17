Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06556C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvoLX-0006yZ-7x; Sun, 16 Aug 2026 23:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoLT-0006wi-OP
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:49:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoLS-0007LR-BE
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:49:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCVSp4118163
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bF5mq3pfVLK27PFz+ig921k3O/n96Jlifjkw0qwxiIA=; b=WN+dcDn8/ajRBERt
 qgy/URWLNdf4QlPy3S8qa/0TcMGz0JkwNwC2GG/HFrfqNbFTZ1KAs/XWnupwWhfz
 sS10XZT8jP5eznxCd2QU8bVGb/juifT1ENeVoU0bvRZmBkeHGUH1BH8wUKW9ht1k
 xlt9Zl494ErfXOjrIUjfTxD+8xh2eAFCIX1DCGMxGuaUsGqaU/94KQBwHP//xpq8
 B3xNf70k1xeS0w/kQU72iRnjYn0es3OGi2IMHfgx5pHXom0gU70JdApVKBRKnvby
 qyMQXyCHyOSV9qPKz/ydE+rlpbxb6wGBwg8t+ZT5zqabOX+pQhJQ1PhUsU6P6wAe
 NTMtdw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfd3kq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:49:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so301562785a.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786938544; x=1787543344; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bF5mq3pfVLK27PFz+ig921k3O/n96Jlifjkw0qwxiIA=;
 b=YgWsYSoeU0r7hxHaz8LyVuMk3L6S8tdNs19NM8079PWzz1W+BODIh+kdHZEqYdVL3w
 lxfgxMZNxj7UI6Au8GxnNe0w9TbCk4zAKCF9Or+JZMjEV/Q5hwWwaVtPgzsZM7Ui48XG
 PpEwYZjk/Z6wVfkaFsYvVA2w5ka5SVf/sBp2Xs8KtT0IbNWisB8VLDeHumEk3J2VKqVB
 BPiErqYGilJ658xeRMXaM1YDeOLQ7eNyHhk6vyGFVZk69OxvMdagRajbT7DmfsWhz4U8
 iaKOY3mwZtcC8KoqW1cSkyPVp2iuu8r2WHvuXTz5+b72MEpDzgwSBhZhdeaeqAcyRQ2x
 qCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786938544; x=1787543344;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bF5mq3pfVLK27PFz+ig921k3O/n96Jlifjkw0qwxiIA=;
 b=LRn1vGKIXzQ8lLA/+l6rhB9MReNLnRDeWeCMkIQ3UkdVt2C8R7LbslIEBDwWP7dYUx
 W2E5qTqskhKN+LGxRm7flz1WF9UTA5S338sEAqmzex3nLd3OtkdSD4pZqcNJufaY+sDs
 kFgXtFfr1tIiXnPkpIZMZ22144/2PvIO9UkDcdJRKc65r5/GYdIrO2pJcgrRa97eJvsN
 lLOBr99umRwS12nB938Oolt5+qsFQ0Z6LaWiZ1qIfmn18Acev0iLnf7I0eNh2h0t7Hrq
 ILKLlv4S7Q13Jb/7MyhurJk7LhHY5myhgc6AN0idlCt7f2EoMkZ1ENPq2I30GToBe6YC
 GVbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKqpliuCUTjBxRmGDLR/y2f6l06gMdGjc/FV9Z6c9twde/oYV6BgiYJM2UmQ2FrUuwbx9tOMppOGux@nongnu.org
X-Gm-Message-State: AOJu0Ywzve+roZSrThiwjOUOuUKkpRBMNHiatHQyZuSD+FkYXbwns+Ot
 V9Oo0b+RfRpQrvzAZSGpsrEJCExErgIHyW+pRHGbY1tLGy8/R3hfGnICa0fu2ngw1cE9+vSTRVl
 CWzwhlA48Ec8vB6NFZTBdFLbPRX5E5WRIK8tLV7DW6TilA6fFu7JJl0l5Ew==
X-Gm-Gg: AR+sD10SxWgziDXlSsItkoivjhZsIZIGcqYnurFzF2Yj3gi6meyuF47GWOheAUEfXwj
 rzmKu53pRfPEQWktKOWSYO1MvOvNato2gVAnK51wokEyi3XLaaUSlvxTlzD6jpbjPqCrxsUQWIO
 dG0AmoG/h6J00iHQoJIS6PI4GzOrdM1UpUJchCkQIf0HkcNMnjBl3iFR+K6xTWrDCVKYqCUhRid
 +27infMRZD56rTrHGyQ+xvm2lpSZa6P8JI0xuk6hMWK+nj7mX3nY90QPQCfzdf5OFXxJ3nJe90/
 aSxbN3CtlPPw41G8JORnP4z+KwUR/SzwYvwNcrP0D/lPOTpJc4cXUrNQFA2D46NJU3F4HHYmxLC
 R2CkqnjeIOt6CRGuOxyyhUB0TEhFtnMFha5Y=
X-Received: by 2002:a05:620a:2b46:b0:934:b798:c245 with SMTP id
 af79cd13be357-936c0790fabmr2887494585a.16.1786938544579; 
 Sun, 16 Aug 2026 20:49:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2b46:b0:934:b798:c245 with SMTP id
 af79cd13be357-936c0790fabmr2887492985a.16.1786938544227; 
 Sun, 16 Aug 2026 20:49:04 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b3a6dcsm110109455e9.1.2026.08.16.20.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 20:49:03 -0700 (PDT)
Message-ID: <56598412-7f36-41dd-a89d-03e22e8214d8@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 05:49:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 38/49] hexagon: make dump_mmu() take MonitorHMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-38-e53fc35bc550@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-38-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyNiBTYWx0ZWRfX08jsSIxm2+GN
 MUt1cC/2m3RgUSw4vSYKfsxkRGNlp47PWaFWCUp1VBvC/rc+j2kKMy9riQYKIjhguX1Gqotzx9+
 nciiYBpYrr/cgVFb3hMo4h2rmRwbRVY=
X-Proofpoint-ORIG-GUID: eHh7ei5XjTR1vTsucyocQXpeV1lZb8R4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyNiBTYWx0ZWRfX1/luFp44YTdO
 yAXQDOJ/0rLqCXJdPWn1Q7YPML5b0kYcKPercJVUFXe5ym5C4QSDUfy7LjnwbDMuyHhxjqaz06p
 SS6BQVtj79qqBEprWbTa4riFUakHpVBmzQtv6r4Sf3lPPyhli44Lpr/c0mYDUu1bBP1tn48XXvy
 dFLjCmIqgfmuhCAqQfIeiD3S2yCLnvgnwYonl03XLNyLoES7iFL/RYaFTHC1yZYsH14Ct1LBSxl
 iijZbYbWBOsuTowtAK1v2/0XM72MAJi+SUKUJPvVYD7iJj9Gox/Z0zSsmwNtaVHDOS+RPyGsbym
 o5JFqhhSsp+dlPvArxomwMeB1IOnkQ2DZtii23BP56TppUsT3J0oAnIt7vUdVWFgrewqg772doh
 rFYnPqnp3C9noMQr9bM3Ub3xmYziEgVh+fBbJGB8rgf80vKwdM1Q3IevcopuSPCu/4+vmQjHwBc
 RRZX8CRJ0TBGJKxrWBA==
X-Proofpoint-GUID: eHh7ei5XjTR1vTsucyocQXpeV1lZb8R4
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=6a8284b1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170026
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

On 16/8/26 21:13, Marc-AndrÃ© Lureau wrote:
> Avoid unsafe MONITOR_HMP() casts.
> 
> The function has no caller since its introduction and could
> be dropped if it is not wired to a HMP command.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/hexagon/hexagon_tlb.c         | 8 +++-----
>   include/hw/hexagon/hexagon_tlb.h | 5 +++--
>   target/hexagon/hex_mmu.c         | 4 ++--
>   target/hexagon/hex_mmu.h         | 3 ++-
>   4 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

