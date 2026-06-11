Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C0ACD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXlMD-00061c-Ej; Thu, 11 Jun 2026 15:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXlMB-00060m-IS
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:46:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXlM9-0001uA-Gw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:46:27 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BJ3Kqv1510543
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 19:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HYLRupdMNNRX040kgPeS3fUnDltbn06fPokcXMIWCvc=; b=mz9xrlWDcqaZq+Pw
 wWuOhFITP1vqHALyXM9bPzD0nGG3lJ1lc64/y7i1APPQH4WoLgEDhN85oPENF8LG
 HKxFkfDjRD4Tvid4LReAt9JyRdvWkBwdXSOmgknc5l2tadvsSsOHb/d88oJVvyn6
 N3mv+/sbJv0BF5L4kIr/wfF5lD4Sy4ko5JET75Bp7eJkRRW+pnLdriBTSZCOnjqB
 UHbdqoInbXnnu8+o9oWhhQgR/zGkQadKxBYfqgiKE/z9psMgK91pE2UdHFucoPDZ
 QTxYixFhI9HWT4tE3B02QpRbgfjR68QzMgctJmHocb86dNkomw4Q5P2qJ2k6Eo7P
 FEYIKw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2u404t8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 19:46:24 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-963c4721732so62796241.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781207184; x=1781811984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HYLRupdMNNRX040kgPeS3fUnDltbn06fPokcXMIWCvc=;
 b=F6p8EbpGI6/X4inx9RLdK7S58lTvaZwCsT2TY9dcveftOWEa/TidIgAPcWrMb4DdKc
 cL5MbgL1WWkwSWTzu7vx7xNStC9pFhwzM8ctVx73B3t/XcwDoGAuKhCeyPylVfvX7/0i
 mniILY81LHjPnnDhUaq1YITTBg7HB4FgLi4J22Gh9XTYc+Wn27jCx6FZQ+KlXNjjptp5
 w8S+NTblZhJ6kaB7bz0aKmYDgc6NYT4J7yuWAsuCrJpLKqH2KSTzPVAPNC/oFgS8PGu1
 ZKQbzFlYAZq1wknEE+iRGewPRGYrSotO1mYR9xzjbjaxu3KVpJjGaxLm31Bx9pS70ROj
 fc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781207184; x=1781811984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HYLRupdMNNRX040kgPeS3fUnDltbn06fPokcXMIWCvc=;
 b=PfW/pOtEUcn1FglBy5L55T5gFxp8cHv2mi1cCnn0AFlG6SlZ9Zs3HZJQoox9flb6VL
 tnJgzc+fDSbpa53EwsQGza4pYjtDd/PPjSPIEQUpjc0jscq4XriGYl2+tsFlLQ/2hRl2
 hBZgFOjgdPjvq0Io1Oc7bI4AvNhh30q68Xx6LmjPaSo53hR2WS3qWXdl+HOoBCZU2MHX
 tuDckUEae6blfmYOoL37FArGbsNpnaBYIVCRXwyWZbIqo6LeguVAcMW9KnbhrtZ3h52C
 VG2EbeBZbDHaktZqpbX8e2hhJBXHQtm3tzhcjOZWo6S5rN0RmSUuRoH08KaJurOjzzSv
 r6tQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ81Z/Rg0FwIiMvGY+WP1FxkZ9YDXjX/OWT46bZyQ3r/ljaiQ5BJ6E2UUEk7ots2msSyRyQwbUA1WvdZ@nongnu.org
X-Gm-Message-State: AOJu0YxaZS5rfFd8r48hTmj5rOEyOA6SxltJkwgL7p3JLVwbTNKQxoWg
 bDLyaWM2DVwoRTTazbBG+dVTYHgDWHcQynjEFeDHx8UM2vELVLpW9TlLqRQjrc8F/Y0b0OIDpbl
 A9eackjbAWDpqntrFiaToCpqPJMkRz5Gkn/qrFPgDOu7O0kglWDSXwLAKoA==
X-Gm-Gg: Acq92OGvyYvHmVlcIuGXFDEvu1jwNkgDp+vw73jq1A8Ary+3WG3ypnGP+4URj9+2gwf
 mQiwM1Pxtg1K8Gvn7gjLKfhY7whYE5kXTczkaVRGIPGcQtc5w1bxHwFlMWxhnmEaw1IhfQAIFEc
 bkDdVPC+B6MZVkOSNMaUtOqh8RQNX2Lt3m/4bZHlKL4NFthghuh6CBzPQOlE7iIyUtgkckV4n/r
 AJ60Esv80DUDuPqVLvJTg3OM9aQnUtdDk+YGO7jGp5dTAcK7U/fPSFvbSUYfq1B6EXAcLgRf/8O
 AX6SYlfnaVr8dT1WQhwOxhM52Hx59CFmbC3PRP1wMtjxoZTuPVwY0hnHQCfKr6GA2o2QFZlgGGA
 /M3H8ev1LAeL0jpLdmalo/+Jhc4qzJ8DrKfZEvT6SatcPvyMq4WKN3OndWW64ueoaGRFmJvhT
X-Received: by 2002:a05:6102:4193:b0:631:4580:6a42 with SMTP id
 ada2fe7eead31-71d5cc86614mr3035606137.22.1781207183746; 
 Thu, 11 Jun 2026 12:46:23 -0700 (PDT)
X-Received: by 2002:a05:6102:4193:b0:631:4580:6a42 with SMTP id
 ada2fe7eead31-71d5cc86614mr3035587137.22.1781207183299; 
 Thu, 11 Jun 2026 12:46:23 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea83d8f9sm7454835e9.9.2026.06.11.12.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 12:46:21 -0700 (PDT)
Message-ID: <7fe9e5d9-a6f8-4488-a99b-e991c74d72d0@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 21:46:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/22] ui/dbus: switch LED handling to Notifier-based
 input API
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-21-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-21-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: diKf5zSQEcr2MVv1_mMd30-bubFcl37K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE5OCBTYWx0ZWRfXyJTAUJzZMR2P
 3ew68yvYJXv8rlxSLNch2UzI2q9IOO5iXgJrfW6kmbGN/OLGH3jzOEnDKqTq/dFBJ+uGDw6VK0L
 5qFXd0UHwY/D63Yuh0WBxhYPQGzZfns=
X-Proofpoint-ORIG-GUID: diKf5zSQEcr2MVv1_mMd30-bubFcl37K
X-Authority-Analysis: v=2.4 cv=N94Z0W9B c=1 sm=1 tr=0 ts=6a2b1090 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1k1Y3PzgwnwA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE5OCBTYWx0ZWRfX5ARddldaxhSC
 SmuU4ku/PDQEzwOuVl6vHbLywiGnQ/UNliKPrcp+jJa8AaZ6QyXamm8mCTnY38WBtBmrYeUFaT5
 SBVA0LMriPLvm7nVRN0wNEdpEVq+6EkVpCyhdXaCJ1GX5zRcWLlSGEqUsRequO1tZfiMcUxavul
 J7JSI3QU8LfjqbwcIQJ9VvsbgTbIMSqXB5yhYLMDrGSahcw9p1OlPQ7xkiZwTZy2xMDciIEAta1
 P6JXOIEUrLbA0WR3EnzRg5lr1deaPQOSKOgp9lGtPNmUNSq8Ip7BLtxqtFbWfatZS9T+W/B/zfw
 CkxkOX5ggoIZdssndmMG4ofF/Es6BpcMOLM/yBFoEPKIk43A2HXCvtF2JksLyzuRek50mh98QsA
 z7znmg8Pw/CSgamzKi8hDfTps45VOLh6hAbV1J9HeO8j/tc9eeD7jyLHLtzhWS5jRh1G7W0TTCY
 5wKZo8ehkdGWMmhNpSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110198
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 10/6/26 12:57, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-console.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

