Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EAFFD9E2D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 02:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvnVv-00070L-2J; Thu, 26 Feb 2026 21:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vvnVt-000705-1q
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 21:23:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vvnVq-0000dy-OW
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 21:23:32 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61R2KKIk236992
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iFFHV2weRbGL3y6JqW3VMYEdzzorRi9EekzsOXPkvOk=; b=Y7KGmj+rDTWcWQiT
 GHCFmiT/5qgcvbkXg5Mj4eDcIwsZl/691OWzyW3qpUCixzZU7Au1Tyqs6y/+JLtq
 pdfY1OqegARsprFkRv+GxRTb4wCf2lARmUES0y6fQwAsxGxmtJNRGptpULnVkg4p
 2bpgXu+pe/PbmC3Nm/Cc3Jbb7d5WB9rod7vCbOoekwzh26x++nKjMMQxR6tZvd7N
 +yH+Ht7/DOjKuAaTgh7+uMyI91GTXCBUjDn0DFWhb7daZDFIekblfv2iSl0fsqxP
 spm0Q2RR51JFBnd13IfVRQDD95kGloVONEWk1cspLEWjj6EXJF9YakH8NK6xH8J9
 WTLycA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjx1xrpwy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:23:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bda35eab74so1089541eec.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 18:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772159007; x=1772763807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iFFHV2weRbGL3y6JqW3VMYEdzzorRi9EekzsOXPkvOk=;
 b=kWrkYleI0TQeVzZ8zUDol7o55w8HhDr2X/D0PkFAaS4W/2TZ4Yco+8wcnHqXBKX8Ow
 6/yxtdoUTxVBsvRXYw72zJ1/DInTsNyL5rnsa1qpUeiOyj74QHHOCmYyEAITn8lRIo9E
 dSFVmsT/1MdItwNAXrfygKYAaIvIZG7lvPwB/pEvyxKhfimtNFcV9g8OIUMSAZHc2TlJ
 JrfCJHmfi17rbggQ8nXkXnGH4rKYXqA9dNSFKcRh3TlfhDA9C3EcMXdhfINuNSG5TzUe
 rHyBExIYkAzqWZGgW0pE9AU3e+5WG+x2MHPgC512oZK3ta2BaKd4KtUM5HuBEZcNNa9z
 FRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772159007; x=1772763807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iFFHV2weRbGL3y6JqW3VMYEdzzorRi9EekzsOXPkvOk=;
 b=eGu4oUPvagmN47eM2WOZZ68/oNDLAGXtMz4ySEeh7KjR7jgCr1M0WHs+AyWs+oAbfw
 uuk5WZXvAN/7NL02dLOY+N3OXii8aCcep+Y9G//xtKDhDHzGUUKYFWpH4bASxDwDTMf9
 UJtFbVlir/flvfJ7wwQEhQpVYvdPH1Y6z/izzwz8cjZweIb6PnQNx+Ew52HMkmGcT1ia
 mxCrV37hEXtbaBlJod6dVwNAYqwo4SR+Blft0LG9yRIyHsEZC5CIzPn/ANv0UYNzIiXm
 1rM9/Ts4amiBTivoB4LJbwNFS6AYRpJfO37Pd0fRrGgUUYwEppcLqMPVhv1nGc1RZhr6
 CL8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLn65KjXz8PLtYeh8sEGQP9RhUlDTwXZD236E23Px4XC9+yUlpy5RTShJ+FF0hUb3Z9SxTwaBewEm2@nongnu.org
X-Gm-Message-State: AOJu0YyYfgegOhEOHQ/nAAgQK7osPeC4utMjsLsnu84s+VRIHw2Rywr+
 7qOGAKxX4VUtcvj67qUzn1KXZFDhH4agBoXKDWNht7p/Zf1tTDf6CNp7KRpWRdxzbtp1hcuaeBu
 kbz4LYYrPs2e0TfgUN76Fx99+JTu1xBQRj1y1a+7c6GrAMF/BAEE2mumSlQ==
X-Gm-Gg: ATEYQzwjj3XGpy/l2BV81NzSoaDRXQDgqP6g9VK/1IxkcBmCMoKSx2fN4lZeuEd748C
 t9sHB2SqwOa8B/9lUDz53ttcj43iYedblgqzrcoWlx4HpVSxSeHXI4onZlw1JoHgl+IiUi0OIO5
 +b/GhyvxXMzzlHlyhZs8GhFQuw8pmT+viZBcnIziLT2oPVnHYH0jxCExNH8+U+C6nnodGPX2Xwr
 X5fOy1bIIMBxth4Ak6OzeTLlBUiCk3AxskP20GeFnMT+TTOETqUA0W1lGSYsMXHpc9YPSHLFJLE
 +UXZYfsM/7lrFql/DtpeMiexvuL+sVYBZBFzqvA/8C9i/oVJIbdWe5ljybyXlc9COjsM/Potjm3
 upli1jHDQoJse9X8h17LZiFcI0Jk946HX0q+umeg0AbiGIDfSPhJR4zXuvnbD+7IFFzlV3z0DAf
 5Zcw==
X-Received: by 2002:a05:7300:a54b:b0:2ba:6484:24c9 with SMTP id
 5a478bee46e88-2bdd0e8c224mr2447448eec.2.1772159007331; 
 Thu, 26 Feb 2026 18:23:27 -0800 (PST)
X-Received: by 2002:a05:7300:a54b:b0:2ba:6484:24c9 with SMTP id
 5a478bee46e88-2bdd0e8c224mr2447431eec.2.1772159006754; 
 Thu, 26 Feb 2026 18:23:26 -0800 (PST)
Received: from [10.110.80.16] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f81be1sm2924290eec.33.2026.02.26.18.23.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 18:23:26 -0800 (PST)
Message-ID: <ad58c432-8c9e-4cd8-847a-df4bd6a45d6d@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 18:23:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/22] hw/i3c: Add bus support
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>,
 Patrick Venture <venture@google.com>, Titus Rwantare <titusr@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <20260225021158.1586584-4-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <20260225021158.1586584-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QaX9eAwq1C7UwKeVl1uKdnDMHyAl2FT-
X-Authority-Analysis: v=2.4 cv=Vtouwu2n c=1 sm=1 tr=0 ts=69a10020 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=1XWaLZrsAAAA:8 a=V2NxCb60AAAA:8 a=8rCgk3-EIUB_8FgfJakA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAxOCBTYWx0ZWRfX4Dp8O4hRH8yr
 LvoE0Lprf7k7yGWPROyWRZYSvjLDGQg04rvwd3PuK0Wn5qXaT0ewapwr4pbz3KDDOK0PJfYUysn
 XijrGorHKjHG+Suyn/o0zpVA4703btzPkx7cR0MtO3ambV76jKnwsKZAXl8d5ph7Iq3J09kWvfU
 jP7NXlyLVGi54VqN0QvfDENKXukKVUU9cieVuly5d/3yVvvA8M+g/8n+qKykql87pTWganXwFLs
 zg89dGuw7bRdhCAGpA+ZmO7/Nc5LIemRbph8VKL6tT4AJqJ6lAGCH/WAFTAkERv0CP0BOnI/sUe
 snITkNSltyyJ8CTky+BxbloDcptoEtKdsUJ62KK+xgdZWOHKES/mB3xoDUMtcOLzeuyt/TxYSPx
 DyUpq+rdGWzyiT/tZGH51wJNpm8nMzGORfw914NCpfg0L1OTLfaksnyVZw5mawLbKThAIUVmdg+
 1A4V7FNMrfuyiMcrQ1A==
X-Proofpoint-GUID: QaX9eAwq1C7UwKeVl1uKdnDMHyAl2FT-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270018
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_NONE=0.001,
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


Another minor comment which too can be addressed later

On 2/24/2026 6:12 PM, Jamin Lin wrote:
> Adds an I3C bus and a target class.
> The bus supports:
> - I3C data transmission and reception
> - CCCs (including ENTDAA)
> - IBIs
> - legacy I2C transactions
> 
> General usage of the bus is similar to I2C. Users are expected to
> initialize a bus via i3c_init_bus, and use the bus returned from the
> init function to do transactions on the bus.
> 
> In order to handle IBIs, the controller provides callbacks to handle
> receiving an IBI from a target, receiving (optional) additional IBI
> bytes from a target, and handling when a target is done with its IBI.
> 
> Similarly, target creation is done via i3c_target_create_simple and
> users use the provided I3CTarget to handle transactions.
> The target has functions provided that it can use to invoke an IBI and
> send additional bytes.
> 
> Along with the send, recv, and event callbacks that are expected of an
> I3C target, which are similar to I2C, there is a separate callback for
> CCC handling.
> This is to help encapsulate CCC handling and keep it separate from
> target-specific read/write functionality.
> 
> To avoid repition for required CCCs among I3C targets, there is some
> class-level CCC handling added. The CCC is then passed to the target in
> case it needs to handle it in some way.
> 
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> Reviewed-by: Patrick Venture <venture@google.com>
> Reviewed-by: Titus Rwantare <titusr@google.com>
> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  include/hw/i3c/i3c.h | 277 ++++++++++++++++++
>  hw/i3c/core.c        | 647 +++++++++++++++++++++++++++++++++++++++++++
>  hw/i3c/meson.build   |   1 +
>  hw/i3c/trace-events  |  16 ++
>  4 files changed, 941 insertions(+)
>  create mode 100644 include/hw/i3c/i3c.h
>  create mode 100644 hw/i3c/core.c
> 

...

> +
> +int i3c_send_byte(I3CBus *bus, uint8_t data)
> +{
> +    /*
> +     * Ignored, the caller can determine how many were sent based on if this was
> +     * ACKed/NACKed.
> +     */
> +    uint32_t num_sent;

num_sent is uninitialized here. Even though i3c_send_byte ignores it after the call, it gets passed by pointer into i3c_send() where it is used in the trace_i3c_send() call.
If the send callback does not write *num_sent (as is the case with mock_i3c_target_tx, refer my prev comment for patch 18/22), the trace might show garbage. Initializing it to zero might reduce the confusion

> +    return i3c_send(bus, &data, 1, &num_sent);
> +}
> +
> +int i3c_send(I3CBus *bus, const uint8_t *data, uint32_t num_to_send,
> +             uint32_t *num_sent)
> +{
> +    I3CTargetClass *tc;
> +    I3CTarget *t;
> +    I3CNode *node;
> +    int ret = 0;
> +
> +    /* If this message is a broadcast and no CCC has been found, grab it. */
> +    if (bus->broadcast && !bus->in_ccc) {
> +        bus->ccc = *data;
> +        bus->in_ccc = true;
> +        /*
> +         * We need to keep track if we're currently in ENTDAA.
> +         * On any other CCC, the CCC is over on a RESTART or STOP, but ENTDAA
> +         * is only over on a STOP.
> +         */
> +        if (bus->ccc == I3C_CCC_ENTDAA) {
> +            bus->in_entdaa = true;
> +        }
> +    }
> +
> +    QLIST_FOREACH(node, &bus->current_devs, next) {
> +        t = node->target;
> +        tc = I3C_TARGET_GET_CLASS(t);
> +        if (bus->in_ccc) {
> +            if (!tc->handle_ccc_write) {
> +                ret = -1;
> +                continue;
> +            }
> +            ret = i3c_target_handle_ccc_write(t, data, num_to_send, num_sent);
> +            /* Targets should only NACK on a direct CCC. */
> +            if (ret && !CCC_IS_DIRECT(bus->ccc)) {
> +                ret = 0;
> +            }
> +        } else {
> +            if (tc->send) {
> +                ret = ret || tc->send(t, data, num_to_send, num_sent);
> +            } else {
> +                ret = -1;
> +            }
> +        }
> +    }
> +
> +    trace_i3c_send(*num_sent, num_to_send, ret == 0);

This trace might print garbage if the target send callback doesnt set it 

> +
> +    return ret ? -1 : 0;
> +}
> +

Thanks
Jithu

