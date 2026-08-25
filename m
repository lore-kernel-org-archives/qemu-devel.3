Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4673CC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyz3K-0004Q0-Lk; Tue, 25 Aug 2026 17:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyz3J-0004Ps-8D
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:51:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyz3H-0007Eg-S6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:51:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PLA1YM1924697
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t3izihmfQOyRXHfO0OKHcu/65oHKxagis0uwBBRJfPs=; b=edCaJMFvcBduIVhQ
 zsHaS0czPN8zZBxquSKMyNADIsF97yU3hcNdmR/z2hxfcsydU+l/r9ftEfTs1p4c
 C/3RB9Z89/rHwBhYjzJi5JYZISLlMy5a9u9FYXEbdCawVYFZv07m1BHcofHYoj+0
 fhwc6504IjEG/wtNMRJ5mPgKhrthd0kOntVv0FF0O2kny8qzfBVOgTdB+/W8Y5sL
 7DKOiflaKST0t3251fZUT4PrT/foCQV8kSMs/fx5NQKUa/fXx+KX7wg3xgO/TTZM
 oTNNKAeuifNvezrlltYD7Qwjgp8iARejjNDxLP0QhXXH3KuXetQ2yiicH+dQQ/Lg
 MOXqwQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9f9urwne-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:51:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0408254aso17218311cf.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787694685; x=1788299485; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t3izihmfQOyRXHfO0OKHcu/65oHKxagis0uwBBRJfPs=;
 b=Xy3PR35hsDLFIWTf3kkhUuUGhqkSEVMfwxqKvT5fMyW//zQ/aMDrUTXmwsJvCr2aIS
 TqoO1LMljy1fPlXOfF6Df+d63UCfWZD9smpK7I4myQskVuHeqj3VH551n7hqWLzxyOOW
 C4KZJQRFBmGvVeQjAxUcB5NKPOoq/pu55AnkqXh/XbLKgMqGIf02GivihkmEanSH4Zfb
 nQzvYN5H3IyKdFACHcEm6BopdjzJnCZ75Q38VBNSSYuPN4EVz0PoJtT6Bgglab+ovNYy
 x4qB4Z7x7IXumq1wWD2oujQoZMCZI1pDMN1Pc8V/GDn/yLI6H3JmVv8NqJ3JXeuFBlHI
 EKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787694685; x=1788299485;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t3izihmfQOyRXHfO0OKHcu/65oHKxagis0uwBBRJfPs=;
 b=oiGCRmk4LoLrB5GCWfZBWIKvaMDLdpLPgvg0eDQ55LW4GWRsK04sUo9OTJnM168Ve6
 fmm6YMoIln2tZttCdK+KSkS9SM6DTmVdpGSxNe/hXNW9M0eLmGf4m+/WvRQevYyQmqhy
 snpfrfhwASMLrbwwjisma0Jr5xgm7tINn2KyS8E6kHl3PVX/Dwm3+ELGTA+D2coOLbmF
 0UuuCfxpmFwZ89Kl/Woou7pC2fHqvHtG4qP3aR8CaAHcCrJuz71ToGOAxRtqJkNRunNC
 ZnLpsNS/60NBMjQ6iE9BYKvk1jULS9VMbWf2/KZvxd4oioL3dPk9ws0+2jLOh4t3h7bY
 7BSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEABm1uWcutRElZwND4d94m5Y7vmvFAvS7lBPDRVivYDNGssSyERSWeKMm/zER5tlMD6qdR4QNqukd@nongnu.org
X-Gm-Message-State: AFuF++k2GF+24QvM8z91UahSeml1jfN4boeFrO34d40GO6+avvIioejg
 1jwD68vcw8OhpptJK/tIhubCogeWwN9gUAO3/bhXak8+sp/umxgKhlgny2ir4iI6JopIta3KPIv
 6SyS5diit/bAO78pNR711ISIFDdEe5KZxteuB2WXRqrLtNgDMb2y7UTWRIODmg36ovg==
X-Gm-Gg: AR+sD10Vmdyhoni4r5ZuYvi+rihJe8qa8IIxF9ddoaob2ifDFthNyZMUYoxJ1elMiep
 9NEGbDeHGyx3KN+37Ku8O0jhH6k072OcCZtkibSKOevBkt5YNVyETkpP+4Jv8meJw5J2bT5KsIC
 +d1pR/wexiXHTlOeiAGIpB/TvhgXflv1b9FfZPU2HvBf2TyG+ptV91X5LKNuSl9QSb4uHQKcgVI
 vHKF3h7QYmtLMTBqd1s1SFSe/nXkM3BJleRvqSI1b6ke/pvUrT5Z0j8I9b5KOkyRlZncUSiELhr
 aywDeC3s6k7lwocrTkC/uXzlL1GHgbZc7siogs7H6zVJIIYcqIwQQ6kNwhYxRB7fvVgsYf2/j3s
 s5XAm7xNRvWNyK608/ip1NiV+7Wh06yAWYjXM5cB3OoN2sHGcbCg=
X-Received: by 2002:a05:622a:5515:b0:51c:b91a:33f9 with SMTP id
 d75a77b69052e-52e2ecc1141mr118021221cf.13.1787694685534; 
 Tue, 25 Aug 2026 14:51:25 -0700 (PDT)
X-Received: by 2002:a05:622a:5515:b0:51c:b91a:33f9 with SMTP id
 d75a77b69052e-52e2ecc1141mr118021001cf.13.1787694685147; 
 Tue, 25 Aug 2026 14:51:25 -0700 (PDT)
Received: from [192.168.20.232] (82-66-243-121.subs.proxad.net.
 [82.66.243.121]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5771a3sm1215265e9.4.2026.08.25.14.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 14:51:23 -0700 (PDT)
Message-ID: <11e692bb-8804-44ef-b269-9f0741d17e3b@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 23:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc: fix trace-events
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20260825074114.853069-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825074114.853069-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0nqqsknlHo-0B-6bKnBTrALTNpRcy52C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NiBTYWx0ZWRfXwFBawy+B0N6D
 o34fjvSUeccoAP5avKy1qf7SWBdfH04VxkUNGb+atbDb+mE4aIAf7qK5mlLR1yCwn7Noe8/Cn/O
 VKr571/UWupPtScfZi8n0YLgBHJxrj/zRDGTu0I/3+mQUxtkkCK5zoCiPio+icHeEfm7KYXWf9e
 TpagwA1CRzzL3vL1Kt6SagDToADpZtAcrlej6Sl8vUTFhMQKj1uSpCOW3dzWs7RWi789p1GyVud
 pdk7Q7oRguqGqgOE2PqVR++nQNjCo1T5VIve8I1dJDUCYWF22gEzHMwmR2GahP2zNvhWolbFP2l
 XRoWJbDohvJJYy18wvj/JW+J/7aQTXOXVq4Rtlr7avN6qtNpY9UyQracuRkozqoPQVc97Y0GEWU
 LA4KNjh7YLLzvyfcLDY9/tBgBwu1kqKLr7yjZPRp+Uu1rju+gP/UUScah4FzelYCoUUdHdxIBuJ
 r+zrrgg4zMpiTH5gP1A==
X-Authority-Analysis: v=2.4 cv=acNRWxot c=1 sm=1 tr=0 ts=6a8e0e5e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=lbskcjEx90pOFJH4cTSgiA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NiBTYWx0ZWRfX2YX2HRZNiDFM
 Rx7drHUGD1pNgiUG1JqFXwbnJoR+nW/ERu95yL+p70XfQJPaxg38W8/M14X+ZhlNjgm3msi5njn
 Gu56TvIx4pv/aIdfgpr11hy05njXedM=
X-Proofpoint-ORIG-GUID: 0nqqsknlHo-0B-6bKnBTrALTNpRcy52C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250186
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

On 25/8/26 09:41, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The commit 8041d1730871 accidentally removed the vmlaunchupdate.c
> trace events.
> 
> Fixes: 8041d1730871 ("tests/qtest: add test for K230 gsdma")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/misc/trace-events | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

