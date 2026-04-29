Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BACFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDOZ-0002in-2V; Wed, 29 Apr 2026 18:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDOX-0002RS-02
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:28:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDOV-0006Fu-9L
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:28:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbv4B2872979
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MjunACGh/RPfSIqpR9jG7FFLD8sE1FYNGbNcSd1MzDU=; b=AYCX60h4q21PIKQq
 okBcmtBDiGsoJjWmc/x9L2BSSAxmLm+RRZXUd+TOKtq1tS24QVzNku5D4gYqdVqn
 R+oq6iwqQRbR7tS5XtbGdThkgnOYGa4VRcLTOaXRC42qjANA/uk5TcFi8Jr1Zo8r
 u07dHF/S+n7exzhBTkehujW/TyWDIlpzPgAS1G2TD6zrvxXyIeNFiTV9WyEI8gf0
 jHoL1H2uzUsCiiGKjLRwBTL5hheF1IrPJ/lerUsSjj0VI/8w9TrH0vyDIkShQdRp
 +10ZuRHpzsCiGhJLKkJENHEWG8MHJiQTdCiFsCN/IOW1g5t6BjRpXKjdvcJxOag2
 cBuk5w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dubq9kugt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:28:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2d93379001eso1217994eec.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777501713; x=1778106513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MjunACGh/RPfSIqpR9jG7FFLD8sE1FYNGbNcSd1MzDU=;
 b=T6aJoW2dd8VeheCUN3XpsUnVeq/p/63fxp3gbt7guwOQ8Go6nC5xk4gCQxW15+SL+j
 wUu8EW/Q1rzT9zQ72EfCRQ7HfjnYrDG5V2J9GyDHRsA7IF6TeXqcsQzobDXlxvAjm1qz
 SRMVuH27SFnhOlrEv3hpN+E1Iz555eXP2B8SjTk79KEiMLz8aCPVH+69yGzhJ5HlJ1ks
 wGErVmnz0pryvuDnQxB9lvmqM80ttQysuppKIrLYYkj+5rBqUdHh/6InyC9P6dK5ulkJ
 LQSn24xvZkDKnSQf7YSm3tCvRcsrk2nCmL8dRx3nnuRuitbTrkVIMT8y/Hlw02bB9MCr
 /Fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501713; x=1778106513;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MjunACGh/RPfSIqpR9jG7FFLD8sE1FYNGbNcSd1MzDU=;
 b=qR+f9HU+OQvxYUgptGja/eLtuS5jOX2KFAVlLmxF6RhQzyABpsNgbGfnN6yWj6hEPd
 lPgIwkcLsyNYSC5tGzYcR43m1PBTN4jBn0st6GJinBQDNHnIoEVVPe9oGp7buhHU/h9p
 fnE0IsvtKytAk6YBUMmWcZ19zbSW1NzhAltLGbKbjSvCQC/S2V3QBKMbCENN9SZSTbD2
 zR9ZgSmupuP+oLDThGRHOAvk1lnqPUfZrwD1vtV7uYcrP+J/5I7Ji7U1qOmFhajHatzB
 Tc2Fp+XAvGoIoU7qte/U0O9IF8QjNtdB9c3pRAuqeXIQubarWRAd7AK7vMYTpNJi6+T5
 gv8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+krDjybUUwISdB/D3rb8GvyrrWUZKCN6oFmJSt4G8WWz67jRR/kCJMlAM9vNR7/jdkCCy3UowPAOAO@nongnu.org
X-Gm-Message-State: AOJu0YzTNQHDonWwkEsabyw8voKSqZcX7Z3AIkeQN+MzjX95qDSuP0td
 mAVxCQQSLAdyLPJY/vGD6TGbh+WjbMSxSDIK8jIMloprO1PYj2t3qqbCfjUWyhb6RjcG8FWuwlN
 583kDAbUrBG/QSAcRwLXVWAudce6JbmPZ1id/nEMfQ79688FisN939vFcFg==
X-Gm-Gg: AeBDiesuDFU2dIZt0fveYZ7E0If1I4kLbTSMigRq1DZG3jFNXZj0QN3Z+3PCRiyWqtM
 Trmb1RKq2EFznfW9qyibXeDHGMOMBw0Pvk+Ers+Pxq2hqSJFra4d//B96RJBcNyox0M/SnmZj/9
 pVNceMM2FHP+r6tiGz7rnDULt1gXwh8PI0aoUl1Bxt+zUxxJEB7i/JQ/K/PG2qOvSxpOmME6ROg
 gqHbTJytiOCC8KTPQkaSxH6UGf/U4/gYdLaZLcfRCWs+FX9MdKRRg1d30UXGjMUEONhcFLg301y
 ewa7GZ0D2+sToboiJjoQOEgy9cBxUc/26Yy7hZ3wNYGv2hrbcA8Eee4Sl0JEFBaiAa/V4JFoZ7R
 mBH+nLEu9Pf/DxP9ipQvWOr34ZK/wRp5BvP/2u9tZKjr0uH+ZRgh4o3BUCz6uWaDanqKAgWNPQK
 rYFKc9KMBxeN2ycLUChD/PBQtc
X-Received: by 2002:a05:7300:bb08:b0:2ed:e16:6b4c with SMTP id
 5a478bee46e88-2ed40367481mr88195eec.34.1777501712649; 
 Wed, 29 Apr 2026 15:28:32 -0700 (PDT)
X-Received: by 2002:a05:7300:bb08:b0:2ed:e16:6b4c with SMTP id
 5a478bee46e88-2ed40367481mr88182eec.34.1777501712171; 
 Wed, 29 Apr 2026 15:28:32 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d315sm4474351eec.1.2026.04.29.15.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:28:31 -0700 (PDT)
Message-ID: <0fcf1045-3c35-4528-bda4-903f4c93b297@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:28:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] docs/devel/qtest: Mention environment variables
 usage
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260429003130.15164-1-farosas@suse.de>
 <20260429003130.15164-4-farosas@suse.de>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429003130.15164-4-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mUbzJLNMZA6_TQSC2RTTsEFS21ikddbv
X-Proofpoint-ORIG-GUID: mUbzJLNMZA6_TQSC2RTTsEFS21ikddbv
X-Authority-Analysis: v=2.4 cv=Wak8rUhX c=1 sm=1 tr=0 ts=69f28611 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kd8EGV1GfTYJ6KBzTKcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIyNiBTYWx0ZWRfX98cvHgN5lGU6
 WVQKyPNGTsyXe0b2EfFXCImrf8s0UbKswuYD8wK9YOFK97fdRMVB3XZV56E1My7R/CNz/nVdo9s
 AEYi7oyLOxp2ULbuhuzvSeloRBIlXjWQrDVFq9WVbhmWVB9OVzs8GAfpE8eut+2GapMGSF185+k
 XPa56jyZIvNWfruoQcnPVwwEhQ77s67wMfR7B1YeW7vMB0Mlih45Dsyx8J+mFFPHsPlUwdFbfv9
 bn9FpfNtMvbf7smFg+/XcRkqCpgmjqvwXl09ZoNxwqiT46+6RaOr7wdyvZAlXZLI7wO8nSjwTgX
 PDoQSsKQW30XSI5j/GIiS2n0jw4IS5EeOItr7I8xVEFmafBIVTZ4eFeC2jivmfwM6QfYTBTVYk0
 bLu8KBpLDMiUwcLq2QQzo3iHJQcKaxFbCk7nAa2ofoTqbvMWoMV4TOSkn9xFQsXnaIpg2Lqbfrw
 kuc/2mkV0FNnPHIF7kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290226
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 4/28/2026 5:31 PM, Fabiano Rosas wrote:
> Document the QTEST_ environment variables. Only include the ones used
> by QTest itself, don't document test-specific variables as they are
> more prone to change.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/devel/testing/qtest.rst | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

