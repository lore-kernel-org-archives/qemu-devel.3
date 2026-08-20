Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CD5C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxBAI-0002Z7-NW; Thu, 20 Aug 2026 18:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxBAE-0002TU-J4
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:23:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxBAD-0002Jk-52
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:23:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK8uo34032671
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3sOq6nhlEp07F6tm6CE9THKXNnjNoNFp1j8/Y3T+s/U=; b=lUQQB2+dUL68VZEm
 K4d/ql8RYT++cX8kH63IAqRSc1NCj4X+OoxAswclcOkBVrx3DL3HeBnHc2GS0+nO
 1g7LM5aM+8cYvdk2+CzDFY5EiFpIdx1e0Czk4XoxDURnHGUL+7NJcB1pYudDvgFX
 tpdQBrsWuURFWpE9vKrcQ2GWLczSdbxZ7khBNITd71dwShRUVeFV5zgvB49qjBgW
 2TOsSli9Ax1ozHg/D5PGF6y0iZeKSELDgnwPzqPomGmWlJUf88Ck0r4wvU+cu6Jy
 6YuuDu8C+Inw3GeUhT3FwB6KGOLQjUGErj9oZGS9VIYUCroETB3EfnuiL09sHtAp
 Z73c6Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbvbfs8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:23:07 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbb467e56aaso273499a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787264586; x=1787869386; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3sOq6nhlEp07F6tm6CE9THKXNnjNoNFp1j8/Y3T+s/U=;
 b=il0+VGPssTodWYl1UXJNGqQsRcjr78KmAGHToXyke4oftN0AzGrFu+ezi4mkZWZoXT
 bYSDG8ZgWp/Ej4s+grFHqUXUDlTI6mEmL/7KPsTTdK/wSuA2eT9ZcmDMx7LqrKAUo0fF
 pZRJHwrJpYkaa1/FoTg/lOFHhqHA6qrC+AmoBiKFYz4844zWiDen7KS7Zzv07HKhsx3L
 fmrhBdbWHslBdwwWzpm/VydlCLdoWZB6qNH4hWWPOhtIUldiybkBOYkRg62scqWwnkmI
 YhgcWfsjrrxkqSwmCXYkAW69HB9PW+tcojyhMu+2JclHNUGVE1dhtmL5Ejf+LpofUyuG
 ymLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787264586; x=1787869386;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3sOq6nhlEp07F6tm6CE9THKXNnjNoNFp1j8/Y3T+s/U=;
 b=ftv29chLxDUipgEHe6a0GNViVnxS3M9UaAJJvY7p0vvoIYk8TDaRkagr5JLd/xS5se
 O+eUGQGEpS4WQy2/WoukIhmsVgBbuofodXYoE62dOBTg76Eas6lVt+2hItxWaUL7rf7T
 H/symXZqw6Mb5YYmAf5TV4rXrhFNhO40ESI442hc7iL3y4eFoe59j29qncf/rVAOpwBy
 BnxtWIgvz3o72UwXGnUFEcdjV4AOBaJFIvPpmyRyI71UEuOk9Lrjommhim2qBPmdDlWL
 pLHxqWD1PYuvvrOzoKO83KQzgtxRueC3rJjG804D0VVayvb89JTJk/w25MFLc1Ef9Zzd
 uCWQ==
X-Gm-Message-State: AFuF++k/sF3/4nfnFPC4NmIeILCjG2QuGhzv6v9nbwKE1PEuGTBhj0na
 gnrqWfv/1L49vHbWCBMBkGfWRxvAtNCD2uwADDmDhOrFEoRy5Rrkd0POHNJJezLJGo0C12qlrxt
 DV2lOcm5Eb2lN8jK2/Vnqi6BxU3mPhx3khv6VRbaxV7FWPb7gxjWtlS/1bA==
X-Gm-Gg: AR+sD10dMd3cPxLf0gYYVC+cNYEMPj35IH3VqoUGQ69g81swbmwRAl60ihCbZR1wWD+
 O1OgC+/Th31PDRa75chKmDK4XS5udFMir0aFKmDZnkc8E4sX2JxMSBZzQ4xwvKw/0AbADGEDawJ
 5n314Zh1iL2zsgpWzkYY1GP+Omlqz+RGn7iNm4IvH7myBuWWQzkbTl5O3x+PqahKVkjEbLDggaF
 JLhgavdCsNJM9V0bnEtIGXBBDb+n0KQq9dKdVSnlk7FvbMn3qkyiBf6RYL/aZI9Ps1nJYvEI4Nz
 8x2z3hs3905heRnl/05mhqOa5zj6HvEmfNHCQmoePNDmfO0BKpU7YkwMFFbqyG3jqF//5tkd6xb
 IZhas/fRrpmnDAAOnNajzLN+CgaImEpWjoyWEFOg2Y3SBXDLI3LixYBftqVHjzZOHinN4
X-Received: by 2002:a17:90b:57e5:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-395c35f0a79mr2846955a91.14.1787264586029; 
 Thu, 20 Aug 2026 15:23:06 -0700 (PDT)
X-Received: by 2002:a17:90b:57e5:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-395c35f0a79mr2846892a91.14.1787264585643; 
 Thu, 20 Aug 2026 15:23:05 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327c3fc6675sm28939205eec.13.2026.08.20.15.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 15:23:05 -0700 (PDT)
Message-ID: <fc14e338-946f-49bc-bd20-d238ca1341e2@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 15:23:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 20/28] hw/arm/smmuv3: Route IRQ and GERROR handling by
 SEC_SID
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162558.2808607-5-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260813162558.2808607-5-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a877e4b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=fgrLqfBXAAAA:8 a=EUspDBNiAAAA:8 a=N__Qz3djUkrl-kfJS-cA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfX1KG0uFFz70T2
 LifDza0++2c5SZbZ3G4c8+AENSYGL8PaTgPABnd8Oto2GMRsLwKl33+wRUJmF2MNKgnJ6QnJxQh
 POs55Iy4FHAXVzTPETtDhDqiWSW5Ldlc60VawQ4Oh4FM+LXYAqyggpvR+1V8Wde4dZcK9lw4BwL
 xPEqD5P/8OlpS7NbJh488USJaC/qXfGAbk3ZsdVw1oIC9f1OXnZzyHqUNTJ00bApNzHMpIVeRT9
 S5pinLe45D2E4Iw1HG8U8Hfoj4eZN7SObFP2BKH7jVBIbejHjS/Q7Vljplzc0CP46f5kyqQc+f1
 dpUiEYga/DN0gnS82EoXU63hCQZUDV7YA+Q6ZfQ2s7lUi7rNqRk/+0aMmVWVc26HCXbURIcxM9C
 lhKnbUiDjAxD4k6DqDTJWehGsKRQD/3VlGj1iEP0nZfjHBq1JzaKcSjVFUZp1ghxbatZq2nUSBg
 m4t6ygSrglsoJOdYiig==
X-Proofpoint-GUID: FCIuuKjQWt01lUlSPwWAPb-aQfZ4jTct
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfX+d9ACa9+85kS
 Tv4vAIqx3O7iKciFDsymGSuZtgghbM6s6ZDN623gysuPQ2c0D92yl6K/+Z3aH2Do7jB4ddWo+k8
 ezm/gSS4fzZId+tivjhM0SNHs+PmtVs=
X-Proofpoint-ORIG-GUID: FCIuuKjQWt01lUlSPwWAPb-aQfZ4jTct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200166
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/13/2026 9:25 AM, Tao Tang wrote:
> Interrupt and global error handling currently always selects the
> Non-secure register bank, even when the event or command originates
> from the Secure programming interface. This splits CMDQ_CONS.ERR from
> GERROR.CMDQ_ERR and prevents Secure software from acknowledging the
> error through S_GERRORN.
> 
> Pass SEC_SID through the IRQ and GERROR helpers and all queue call
> sites so interrupt enable checks, global error reporting, and
> acknowledgement use the originating programming-interface bank.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

