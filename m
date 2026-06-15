Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A74CD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4h1-0006Uf-GL; Mon, 15 Jun 2026 06:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ4gr-0006To-ID
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:37:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ4gp-0007To-Cz
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:37:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAKlR1291130
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EYI5yEaJ3vAkiNTAsNMT38iNKhfm7T4GhZchTSfkFUg=; b=gXLtbENwP+nGMct2
 Z+GR/o3WjmbhaXMuL7OZg0KDcRhoTTrtjYmB6hdUqNfb0M4fhvKvKtYfhNpvguOh
 +nGJpWhdf6Q6SpIMd3n3DnTRgMyy7SkaOgz9EbBALD8liEulyBnP+HdpGXnESOvZ
 h1rfs83OPSjVBedqf+2Hn/wd424v7F/ILeIM25Noxv0FQB+Xwqdj++HT246MUYxf
 nIUaQSsW6a1GuYhR/sloC468hbqlfj6XdzxmfCBdwtujF9eW2TRNnS1epafB+VDk
 /FrYh0EdkQKKailRFqMUGt3HQVUHH67VJyGXRpSdMiTlLz8KHS+hLiPm8pOUxHur
 wynKhg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2c8rjn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:37:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915f6ff639aso939574985a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 03:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781519829; x=1782124629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EYI5yEaJ3vAkiNTAsNMT38iNKhfm7T4GhZchTSfkFUg=;
 b=kTywtTOxRKOdMo62NpnAlQ1UUOJErflLS4XcyYp10u3y857eYq2oVGxQHyGsNKrICW
 i2lV8h0FLgTLWOh48KG9QZ9JpualhGBMfqkTw92Vf1EopMbWFNIXBDGAZpKKaM2vC2GM
 2U0NJywqyaQoYXStMD6xTqw6To0s9neGZhGRdkuYGfKhu1ueqscuXGrBQjuqEeb0nkK8
 MFzNssIfH+UPyMsZ3Knpzs6JxsrVH/BnFQprsdQSlMdFsUN2KLZzRIKZJ0hHwlEGyAk7
 aB64rgxBmnwy9Ntx4Ua1FghckXgw5bMP0AUUBlFyTTlqdwOBWAEqkhLgNS+bkcPIkL8x
 G4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781519829; x=1782124629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EYI5yEaJ3vAkiNTAsNMT38iNKhfm7T4GhZchTSfkFUg=;
 b=PusHPnYTi4aGlBNPBhi/gwXXb/YjLYAKifq0ZOTpzVnxzg3uKnRT/Ubplnuz+Zen4T
 mM9q+NqwMMMalaPjgOzRkejlcjMp0Py6LwEus8wj4xvb4KADmyn7oxoXiGB57k+yacPN
 va2EQ/N2dJm7cbC92DIVVPis5jKANf2vFobuzuQ9qWbLRaodIrjA/yTuskeBw3NMI5lQ
 XH03pmxzK94oHv+k9g05iiTMFIpsBajqW0fh/TgghOJv9IrAKZFuvfL03wt90gmZjea/
 jijwEe0XK4RsFtSXzJuGc51yRhueCaSjVWBvVrgVQeayaiDsNJeoN1wBfHNiSxATqL3/
 53Bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HgSiyD1toDiIEEJrkN38kuNNY7FVk54DtEktKeWtON8wPna+RNpH/TvXn9op3w3jCnLTbdq9klIKk@nongnu.org
X-Gm-Message-State: AOJu0Yz5TfyvuJ3zqTnOiVGVx5PxiEGgARdu2oWRKzIjUdD6oSu+XQH4
 oqAMUTB8VBwA2wDwEu9f62lbw99DMBf/cNQZYJBstnvFcgf/aNWD4MvNkWwRznnXLmnF3NrLNGI
 DNhwgeth1TjagywQDxMUMxwDsTwFsp0e53TzhAZlNMJ9SpOnjSsGL5ETtPA==
X-Gm-Gg: Acq92OH7xOyrqimoNk+fFTLglJf2mpuDp7BlcK6cbPLDoQ7ZnhosrhnuLG/SJsVBoHv
 KO5zH0y+oCRgwz9LFKOMZ2pZQR20nlY2oPDJyqpDB9DfrfYPcgRkZSNL790iIgCbr9Kwt8Q/uXK
 azxtF9i4oywfKMiw/eb9YPaEN/ypLe/38gEKKOKhTY3gGYD/s+kA+8XeM20IqCdTDTgRRszh5mA
 f+iGfmfymRqdb/wafL3bWW0pxohl3YeuiEHeQeev21ItJyfeA8yoZ3q64q+EHVGJcjLzUAGPzQU
 iUZRbRTf/2+7maUpIGUo70i85TCcC6+6gHcw4Jezw+O5G2XBMIDzIG+NyfiZ1JADQcTgaLqziKS
 2NxzGrWAXTAG/JinSydvtgmf7Ztde/8WsEHTqr3wsdtdFT40/agHnR5Vz+u3T2ZUs1JLCkotm
X-Received: by 2002:a05:620a:6606:b0:915:eec4:1ec5 with SMTP id
 af79cd13be357-917f243e101mr1584124485a.51.1781519829361; 
 Mon, 15 Jun 2026 03:37:09 -0700 (PDT)
X-Received: by 2002:a05:620a:6606:b0:915:eec4:1ec5 with SMTP id
 af79cd13be357-917f243e101mr1584119985a.51.1781519828876; 
 Mon, 15 Jun 2026 03:37:08 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfe5116f409sm405186166b.23.2026.06.15.03.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 03:37:08 -0700 (PDT)
Message-ID: <7373aec7-4638-4b45-8ac3-7e68a940c7f2@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] python/qemu: split console from harness args
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260614100902.885698-1-alex.bennee@linaro.org>
 <20260614100902.885698-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260614100902.885698-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDExMSBTYWx0ZWRfXyZDtKiIcWQQo
 OcIDyuKOUhx9wWBjSKo6pfAdNAjLeNVk+ygZvIDhUxlrs++uHnKXzooiL0CZ1gfsVJqosi+nxbf
 fKrOuI1iVZF+XIJXFMUrZ8uYnbWUnYiyqjNhGeRR6blknQ4ntjAxC0X6lwA3SaVs90Ln6LMVjnO
 m4GH0N8crK/gIzKHTuPl7DbA106rRL7L6622oUR+UkuY1ALjk6+fW81RPOhHyit9F1pkKUxrl3N
 3ItfcH0QeUY05HkJyYtr1LqmjuBdNiojAx/Vz2+OO/hiU+05FKwas4z3RgIqM2qckDqJWVPRshk
 han2XTWDGtCJ/FmeCiq2243ds0uKF/WHZ6LeWJZDDH7O92XK1QlFZ6lZJ3v+Z+cSZTCFHIefuRL
 9S06yhs16fxEu5IJ/KhVvxA2o3bbN3VL2hNQdckyP8ASuUVQ4A4tdO3hAHdsOOwJg11cB0uVGsF
 y1/TKm0yTj9MLBJRY9g==
X-Proofpoint-ORIG-GUID: 9BsjOIeAtZl2CUpX-a8yIfB99CYJ-N-A
X-Proofpoint-GUID: 9BsjOIeAtZl2CUpX-a8yIfB99CYJ-N-A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDExMSBTYWx0ZWRfX5mUbKgHueKXn
 pMfWpAoEWEGpjSuz0Xxjwn5gMvxtXcvDgvAmGYYk7TiWcipXMLG3CVg2jy7lpdS0NKBn5RtazbQ
 PpGj8mdPpz+FU07QaOJ5A20ilS9XVZY=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a2fd5d6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150111
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

On 14/6/26 12:09, Alex BennÃ©e wrote:
> Before we mess with the console output lets create a new helper just
> for that.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   python/qemu/machine/machine.py | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

