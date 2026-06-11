Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8D1CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdUl-00018u-33; Thu, 11 Jun 2026 07:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdUi-00014d-Va
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdUh-0000g2-9Y
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xAEO242609
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ez2+FLn37Y7xW5Ic9ZLMIoi8aD6eBdTTQMTLyOnm3Aw=; b=hLg9cLHAJABe+DKw
 C1fn9l9mzWkLz0vgmtqBInA1loGL2XbfbgSb4ny8wV7UZ5xELAD5uxrKFbUhzldL
 Nap3gJsuAwblCC0bHyWA0W0kNcjMQgmxqz1XvK/SLzt4C4jSUtUo+nGJZzsf1rVO
 8cZxZVMvuIsdtVqWsDb7uo3rHf/b/DM31C6xBQlfzs7Pb13dEb1X+v4eBJWnn6U5
 8Td5y6AN1PsYBGmEd6zozMMD0hXOCyXV+e3moqP5BfGs/U1hrGL+Bt+4eeReTSHw
 oecRWWMxE78TvhiNkwo/VOWpvQzaPs49RhIi5S6lb2fJ4XzT65HKRw2WGxp782oS
 HHyArA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe7035m5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:22:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5175bf22b1bso109212901cf.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781176960; x=1781781760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ez2+FLn37Y7xW5Ic9ZLMIoi8aD6eBdTTQMTLyOnm3Aw=;
 b=JCPLBfys8VAFhukIBP3FfBviMcv+vbzTREhqqW85+mplAyAld7wxDNdhlmSUVxKt9N
 m196RvyZaWOgT76gyRAu8tRHsO1q2XENJiOWBmgy/kLsYb2IouRaDNhQ59YTjAoppQ4K
 4b00c8EWQDxxWfMwgp5hxqrzLCMANLQS55DYihuVAyrpI70bkirzpQffJkGsprgFFKmO
 gGv6qVjqnl5PRSZ3Bwi+HvVQmgKlPD1BIRsQqRpY0/fe6BEMWWMkkk8x3Ufn1iCWw15W
 lHJkPPw4jeZ1MYPCLXOBhL+ghpF7Ykt5kpvlUcI4zieIKBPeADMvkmVvFb3xnerclHAc
 TSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176960; x=1781781760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ez2+FLn37Y7xW5Ic9ZLMIoi8aD6eBdTTQMTLyOnm3Aw=;
 b=Mv3ApMjmpXC0Aq75HGKI9m7QH05slTnz2anG7MB73aa0Cmn8vMAgBW/O9o3WkpVspy
 JTEZz7q3AthBa+S8tgAfwPF8G8c1q5+wckfreHpm/DY+uxHZQzr79qFqigmenMZzGvHD
 H7IiOTop6HB2e3MskEwv0WcdWgomH7dPjM3fAGopnvy0TUhf0qHfDH2mDoUmigIX+lV1
 kX9jnAArLxX2AkH5coOHLyNvVIWrT2/vHcunL0s/Iid7IzB8dNFM7sXw+DsI0uvrWj8x
 lRa4x72qCjV+CgVCOfwR6ejfxgOvF21irzDchTjUcr8ZbaoeOH/KuYmyZiV9MpNv+OIk
 z1qw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nRleUxVcBr5l/kMIG6XwZPD/nywKXzLrir25//z2v+3MHS9zZkOZec1Mht9/XAyjFWGhmn01MOO51@nongnu.org
X-Gm-Message-State: AOJu0YwwxPU6O8aIeOM6reltNMeAwviS5b49/0NQ3vhszlsEHNfouDRv
 Wbpqb+wFv+ZaPJV3hCJK6SwpAggoZaDBOYgJwvM3QLw6O+I7RGxqTEjAh5HBxImDUp6w/OlWCa2
 CzneeSMzRfhhq5q6MhnK2AMC4L3rB2ep1Bni9Mey2/uz0xARMffxmFhmgnQ==
X-Gm-Gg: Acq92OE/+RfizCf6RIiBZZemfVvaXNb5GZ33uUeMNOy8xAHWZWI7cXbcMheaMFNenyA
 wkn0n4wlOlLZxuYqmKY2icwLuFzfcm54LKSAqCm2q6TiBJiR95fMm52yGBBTy19c/8QxCaiEb0q
 Bp5SDqxzsX648gYwOu7IX1jTaTCSFCfixdR+mx1CQgrqddU4CPesrufmIx3usfCeISQtXQSF7jN
 2PArXHdGeUEn7u7fWRc04k/IsugOw722JS3TALV3XSweGRkDJ4fWdnKXDkoRIxRoZGZXI491l7T
 Ya5EA4KR+SI5JmkykMBscz6HgXkJ7aG8fNbAajPhjm9U3bJXvVj4nEYYb8wYmkabczesqeTKU+3
 J87CJJcWQVvNPoSSFAA9XHI9n1ZopmAg0JkfO3I8zvl9PiOfi5aqQlXdWPSgvZfkQ6S4UZdTNMy
 TrqjmezR9+cYmC
X-Received: by 2002:a05:622a:118d:b0:516:dcbd:aab9 with SMTP id
 d75a77b69052e-517edd2f583mr35838131cf.16.1781176960108; 
 Thu, 11 Jun 2026 04:22:40 -0700 (PDT)
X-Received: by 2002:a05:622a:118d:b0:516:dcbd:aab9 with SMTP id
 d75a77b69052e-517edd2f583mr35837771cf.16.1781176959545; 
 Thu, 11 Jun 2026 04:22:39 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f360bd6sm87145359f8f.36.2026.06.11.04.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 04:22:38 -0700 (PDT)
Message-ID: <b89d2158-b8a6-4122-9ff5-d2eb69ff9ed3@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 13:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/22] hw/input/ps2: use qemu_input_handler_set_led()
 for LED state
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
 <20260610-ui-input-v2-16-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-16-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExMyBTYWx0ZWRfX1VV7Pa/1IUCb
 95h1ePaOLN1Z6EZfeudbTJCpmaAgAH/5VwKnHpjjJWcXSJSAUO/IdLAfFpjmlEBmu49Vuni63N5
 kQ4WLWvE9ckTmlAH/pn26GwI1T1f/DpQCJIU9Q0H54jS6saAcDEeA4rHzIc27Vhj6o/BtaznU5c
 RY++GjWj11ui9CbbqxE/v49pUZGsfGfqK2VbecSRCnCp4W7RHsbGQ8DuX63AmSH6tjWuqCM15uN
 TrByiDmFrmVBksUdToCk9UYLOGMhkNuyhGI5L93SQHnRx9IpQUTaRPc4ABUb4EmQ+g6uY2414Ny
 VO/+UqUuSwVwYxKsxsVgi2HrgLlcMu1jfTJRePrYs8iaXaC7h4yBXFu/P76RrMjNdyXfHeBSAxU
 zTPPI1TtqPJ0gF2NGkzh2PYcaWDaJLbXJZS6Hwu8dpaIfVnTzpmFXezxc2AnT9QHHkPPEVQl/Cd
 CBzyzTOBMRPbv3RCb8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExMyBTYWx0ZWRfX3JmbmBdImbfU
 x7bUuzTI9qeIqj2XdXkhQFh8+6coodvkI8/ikVqxRI7Y4woauHi1bImzQSxOlKjqlgJOAt7QiOf
 mRiZqTkanU8whmYiSkZzWI15VR2zY9A=
X-Proofpoint-GUID: kbiSdvYt0FnLrKNMjCkAE7tfndzSZsur
X-Proofpoint-ORIG-GUID: kbiSdvYt0FnLrKNMjCkAE7tfndzSZsur
X-Authority-Analysis: v=2.4 cv=Z5Tc2nRA c=1 sm=1 tr=0 ts=6a2a9a81 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1k1Y3PzgwnwA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110113
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 10/6/26 12:56, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/input/ps2.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

