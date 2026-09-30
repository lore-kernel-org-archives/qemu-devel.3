Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75960CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxQM-0008GW-3l; Wed, 30 Sep 2026 12:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxQG-0008Fz-Dz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:44:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxQB-0002mg-OK
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:44:45 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE0Kcs3943265
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p3YTzby3+4biCPQVGcjaBmfKEhd+nQqGoRCNA3hvchQ=; b=Toyh153h+OkFRVKx
 1Sv8QoRBIWpV3ZulJUZEvVxO9zJpLIEwj4yu5dt34SmX/HHBSTQZWHYLZAxivFv6
 hm3fhju5HoeNijHyBJxhRi0mJ9Z3Kq1eohZhb72BiwDb8uF5WhXpvDlnrA7cFgmN
 6vYpmmzPFCf0uXef9iPxzQf2W/IbEUNhFOIt4pa1M+npiyEjbY8cHEJL4SLrytvR
 Wa9h3aBL78ri2FFt0+7qZ90E4OrT+fLXTqOBSgq3gCKQV5l27WAmC4beQfijxyk+
 TIlMw9uxf9ZRmeefzt31qDtwbSGyg9FjIFcFyDrUFKgp4tWb9f5yIrvd7BtJAxgt
 73pTyQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h10bk9r3p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:44:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf7856ffso111873885a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790786682; x=1791391482; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p3YTzby3+4biCPQVGcjaBmfKEhd+nQqGoRCNA3hvchQ=;
 b=eAjiAeixB99m6wyr/O4OLAiNN9t9/xOP0Tmg8M7pT2p1benGcdElVru/pgGE5siS4S
 83txGVAfLZ1uZCpmbxrIFIZBLnuU9oNFMqWU0R+rMZNJdsHW8wH4UDrWKcQEU+yvBSt8
 v7dQZBRUty4a1cJY9qyY9MnUatdhluuTHUWrhjNNeHoY1EzWcSCuWYapxoMNciratto0
 PDvs+tP7j7hhtFRXscdUaGKXBd5vbSaph37h5hCQyBogrvQOCRKRlM5qsM1emFBdjJi3
 O6Gf+qSnUrxQEHFdSmIMWfcGWewm11Fc+57XfjaYcC5n/mPy+xohznpyZ7sw/9M0Rnq2
 lkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786682; x=1791391482;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p3YTzby3+4biCPQVGcjaBmfKEhd+nQqGoRCNA3hvchQ=;
 b=tjcuy84cSLG+vIJXH2cCjXOXxClLFjycp0ufslbwAwadnRtT0Ix7emxv3+xuGgQZ01
 Okyw3Q+VvHpLhD63TjRMjG3cpgLJRkk2J6pxnuLQvzbRsTlh/LTjCuPhVEinBSFVT95F
 BcviU/Hfo34L6u65Fv02wTIxO9vYdkskehSeqE1GUAiB3GXpoH2imDlwklY9OMZxaGhp
 sPOPP1bnUpcbmHCmYSjFu+/Kt/LOy05KbQlJCpbDKJK5++0B4ZpTfS8NYz9ohxoB/zPZ
 3vioYZ+L+raJ7X7iHglhbAk8b0GUOZ6JnIXEO0RSvcrMsHG3QPjzQXMkgDGI1eOvm6Xd
 Y89A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+9dungW7ruCaywCJftzCb3foUFWsnwpaDri5IlDIcHQShvRMa/+oEraR9Nw/7E0nDA4nY82hWnW4r@nongnu.org
X-Gm-Message-State: AFuF++kpwhBG7cIT6LL6TuPpcdBS99+Qr9dNozJS8IqleuvOTN+QQzrF
 ALkyzblRDfuAmT5m5UxacwELoNucaUU8jO0U+TBoiS3P599M3MX+bnTxehJiXBmvjW4l5NPEUB8
 ZmWJNodLD9V5f4OCUzBK1xdfXZAqbZHlMDRcSBRfqcvphJac//FtvWtD/vA==
X-Gm-Gg: AYBFou0dbmQitVAu2VCwSGX3DzcrSJmiwCre9McUCC1eDxE0uoy789c9QfAiNtBOjZE
 Qte8YVNrMeN/9N0fzIQrMmDg1O/ATUELZmcacBh9s8AI4pZTT2WFIHm+pIF6SSkzNQVqV9bA3b1
 creXUixQfVOuW5m0ATTmZfZex6zAidwJLSgumRiwDT7ZI6mE0jVWbmbgIZlg/HA21BIA55XzKuP
 Qk+D09aSHmOMzKVegoSm8VYfzI89O4/uv4Z2MYIAsu4nTnWvSzya+WID+VfuPlT1QN0/zSp5SdP
 2RyCWGye4xHByQqkHIFDidcfRo//igHBP3pFI65JBj90Zw8bW7j2V0dXjn3zex7bhzkYu6E53ob
 Nfe9aNrwgpIgrhwIIDOk=
X-Received: by 2002:a05:620a:90ce:20b0:93a:14c3:72c2 with SMTP id
 af79cd13be357-93ca97d314dmr248181985a.29.1790786681646; 
 Wed, 30 Sep 2026 09:44:41 -0700 (PDT)
X-Received: by 2002:a05:620a:90ce:20b0:93a:14c3:72c2 with SMTP id
 af79cd13be357-93ca97d314dmr248177285a.29.1790786680989; 
 Wed, 30 Sep 2026 09:44:40 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb5de74sm3939265e9.3.2026.09.30.09.44.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:44:40 -0700 (PDT)
Message-ID: <dc087b47-fc79-4200-80cd-3deb6ec4e23c@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:44:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/27] hw/usb/dev-smartcard-reader: drop current_bulk_in
 pointer
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
 <20260805-smartcard-fixes-v1-15-187ee9122441@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805-smartcard-fixes-v1-15-187ee9122441@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lGpG_aKw416tP1fFZlRjyz1adp8_VoT7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfXwm2BcI8eatt6
 YxS300gRiOfLpKjaPJ3ex2LhCiWd8rp9mLlFcuKLvsr7aB2/A7/rKJsPcq5MIk0x9QKrsPX0F6k
 TphaTbjeICoM5Cqi3EQyHgfRuIODE32jsgYEe6Xarcrw1x6QH1/ge40wZxnu+YxCQWY+tw1eefM
 Rj1zyB8m0uW93AhteVw/ry4iMMXIPpjThJlTbAI69KhBpuRpKTN10txFWZrBzhoB96bSDiO8xz/
 b5lFGvHu/GrMNy2BjGXLXvo0t1aqxDBEPhKYjzJsp518gHRmeAS6UZ5WItG3g5uI6dCoLWn47+d
 2nR3vrztrjfPBrx/GLXo9Jw0XvlD/cQxGr/XardidZ0Jsvll4HC08iYqWMHoKIErPkHqGaopXmH
 i3UkYRb/RS3CBl4aeoDkccZN6OJ0mMtZYHialjY4lKnhV6mcYGgwphoJZhxuQUUzr8tcU9Ei5S9
 6ITXm4GLvrelZs1jgmA==
X-Authority-Analysis: v=2.4 cv=MZn5KJ/f c=1 sm=1 tr=0 ts=6abd3c7a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfXwi4sdKVxLmlB
 jBHFI38NLC5Qqu+B9+OPj/QklEGPW0huysi76CTe8aX5p2+dSiQLB16NHdXTC3hhWowYDQr+UWV
 KupNGzIfNbTkuEksm/ibzM8JHAYg7OA=
X-Proofpoint-ORIG-GUID: lGpG_aKw416tP1fFZlRjyz1adp8_VoT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300066
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

On 2026-08-05 13:51, Marc-AndrÃ© Lureau wrote:
> Replace the eagerly-dequeued current_bulk_in pointer with a
> ccid_bulk_in_peek() that returns the head of the ring without advancing
> it. The element now stays at bulk_in_pending[start] while being
> partially consumed, and start is advanced together with the num
> decrement in ccid_bulk_in_release().
> 
> This removes a field from USBCCIDState and simplifies the bulk-in ring
> buffer lifecycle from three states (queued, grabbed, released) down to
> two (queued, released).
> 
> Note that this changes the semantic of bulk_in_pending_start in the
> migration stream too. But since migration with pending current_bulk_in
> was broken, this doesn't make further damages.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/usb/dev-smartcard-reader.c | 42 +++++++++++++++++++++---------------------
>   1 file changed, 21 insertions(+), 21 deletions(-)

Great.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

