Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE9BCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxGI-0004lr-Gd; Wed, 30 Sep 2026 12:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxGF-0004lc-HW
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:34:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxGE-0001o4-4O
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:34:27 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UFX9wj194746
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BtK1WH+2qlhCHGUcHJRCWQ3qjq9TVsOmZzpAxBDHWwo=; b=ZswJAEe+ll015ghb
 NYC/N9y3N9TksbaxU8W5wIsubLEXGvtwqarXtIaTNhnuMeUvodY5nKDXy0zcRgAq
 NJh7cjYhw7Hs78Dc+wXuvrjPbcjArxtca2mNg8ez2VtHSTh7u6zcDP5iD6Z6liKn
 eE+8iFbUgxIjG0fAMsaRyEh1oyHlIgSbSyyc6hO0jIty5TnqBsIYO/RHifd8h1fE
 XUn2BRN820Rpiqp7NIL37ThhbSXVuTjMdKJzKPYU6I1LVpEcNoOEO6Cx6Avy88YP
 xPLYTUcwyVM8YFWVougjdAoFN2sWmiDmOhKR/8y2IV6tQixiYqmKxF46pFHSE0Qp
 JNF/HQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h155vr89a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:34:24 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7bf651b26c7so49044137.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790786064; x=1791390864; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BtK1WH+2qlhCHGUcHJRCWQ3qjq9TVsOmZzpAxBDHWwo=;
 b=Em+NnLoPcb3fMGwP3RfSCvjLHfmHwt2/9DmC8ur0boLEYWM9dKP92LNLThQ8dmbaQ1
 foFJBm+GQlZGOgrhESn0Km7/bTd2yW3gvXs7bvDNpTQFnRviiAX4qo07fuHJX8XP2lKF
 gBuqyaX0aI3lj//R6xcaxvkW0iL0vzG0wka7A/tz5Mupgrw7DO7lb2Hc0YSUK0N9bw4h
 8ov9s+PR6qAxKb5y5tCVM2oIhIFoLQ/r1Jd/r9KMfda+LPvuZ2tnEgZLeZ6T9hNinyNf
 +/MvxjDMVYBhwSSz5cD+/GdM5txWEbDMZRBYOiFC4cl1RUAOw1/p6/xJMa60Ezqb841n
 fUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786064; x=1791390864;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BtK1WH+2qlhCHGUcHJRCWQ3qjq9TVsOmZzpAxBDHWwo=;
 b=uR8ZwSYhloFisMrfRVc7fOs4m6L0zdUbar89UcNsSKAkeFBXqRMBGNC+Eu3EF+JUEw
 ZM9MtRRRvmBvubpVMz7iBGvZAwpfrC0f+QrFc6dgiQZZ9I46Gn1fw4UvYIgSafU2JQau
 F5ud0/kLeKJdFfCcbpkxmZMEkqgFRoZcrslUoNczdJPcU5T5X3egJAeuVanB/1Jlv9En
 5ptkxSd6g+d1fMS73fV6NejAOrgP0s9zsrSS0O7BuBde3lQKepR4x4jwupYUXzqmnwIE
 yK3/lzcK3bhPCvNxcaptyy1EKI8QISm78bdUr5mvkHWxaoLi2yuRIvF7jF0NZe4oP9bV
 ErOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzc59I0TrxgX6Zr7THd+iFuwD0q3Shoep+UAF+Ch9xFSi4K4IdhEOuAMxnUOtYZer+gZJRQIrW3S+MI@nongnu.org
X-Gm-Message-State: AFq9FYJLXPlCvBaOj46X8cShhJrRcje/GEuTmYWOhEtQ3yD5rtJ1fCI2
 Mf1G2MT+/1L/KIHHTbkcWZJGyA4HzAYjFHdbXRSYkD54RJVh4QoHqGM9WzRtN0nkTC1vIWsnZ4L
 8IYatr7DJHlL4zAubj54c2BhbPyh7abpiMS+QKpQ8XbGpnj6ey8HPgg2U2Q==
X-Gm-Gg: AYBFou3CECN8Bp3tmwIgZX6RpX3vbdYJb9XpWRcmbXpnFTpj7JD5xryGGjI1Zmq7hfY
 gdwTLqzsrU1bWQVdiDRq8uT0KIvhddQqB3jqFUPTuL2SfEOrRrMV2Kkc27pm6+HdgctL7T9/4HO
 1Vl7zNoZGX+Fl13peHL9NfI6XMnw160cBVC6g6m94XPFFzltsmZ2mbMEWWKWLG7SU/i4H9F+BA7
 HeS3xNhxyfopzrj2LPqfZXPwW2nuy8mDsEhJMcNn2Qp0aTHKADyDVSJV31sCK1rlJe3mRZgbntr
 NxjIHzYlu6SWP7MF0fiBDZNIvpfW/io7w/M4X/bhQ9x+t7pNJBZcE4VAT7dmMInzxcbUB8ST6RR
 dQkPLZI3duZCdSv4voQo=
X-Received: by 2002:a05:6102:fa9:b0:7b5:7cd5:2a1b with SMTP id
 ada2fe7eead31-7be72cad341mr455663137.10.1790786064029; 
 Wed, 30 Sep 2026 09:34:24 -0700 (PDT)
X-Received: by 2002:a05:6102:fa9:b0:7b5:7cd5:2a1b with SMTP id
 ada2fe7eead31-7be72cad341mr455654137.10.1790786063462; 
 Wed, 30 Sep 2026 09:34:23 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ccd1566sm23400085e9.2.2026.09.30.09.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:34:22 -0700 (PDT)
Message-ID: <fdcad803-58d5-4ff3-b2bf-db9e8253953c@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:34:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/27] hw/usb/dev-smartcard-reader: decode bulk-out length
 as little-endian
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
 <20260805-smartcard-fixes-v1-4-187ee9122441@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805-smartcard-fixes-v1-4-187ee9122441@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX4m+2As15KoWa
 IKd1beSptVRLnsfY/3uCkLhq4adMsmBgGrgXQAF0dAlLhBsW6W7SH7lKIultnK1aUp/YUaGg9Y/
 ifxVkUq3/Rd704v8o0wjv4GvMjZWN04=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX6y6NlqEi5/Yu
 iix1tHVlzKHNniuHuGFJ3bz+T/1o7zoT7O+DznC7Ss444/6Ou+M3C/8DQYhY0euxZYgBsoCC8ml
 5ET1XJ0RcbJ9BXGvXc5rX8ed/w1VQTizF8hV3/NHZnSTBkjuGpoQO1nCOFEdAR97RRf0uSTsDKT
 +WJfJi6LaLyQeHKo6eOnbjKru+3lp14be4ZdRwLeqB+nGVOn6dfT+p4pCdyBesl9zQerOh96ZRt
 dkrt8d88u1sdPELcivgMUA+BcRstM93mbSmqnVUVEr/OB3OQxoSBMaX/y5JFDisugcnN9uWrZa/
 8UCEQnlC2fu04PFjnKCByAgHYVwXkEr3b2r8Lodz8srepWBit4Iap9vd+fcUmfWbD6YfWL3hlLx
 d9u1nUUCtidqlIBL1sTGMySfDdHFJt72eeHIHo370Yqlg5tBRa33OTytLUrNWXAM32nGhzpxLNG
 QA72rq/NL7QSVaxfXfg==
X-Proofpoint-ORIG-GUID: dgzyBJC7ULkH6QMLNguFA7xNk2abwVdP
X-Proofpoint-GUID: dgzyBJC7ULkH6QMLNguFA7xNk2abwVdP
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6abd3a10 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300066
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

On 2026-08-05 13:50, Marc-AndrÃ© Lureau wrote:
> The CCID Rev 1.1 specification states in section 1.3, Document
> Conventions, that fields larger than one byte are stored in
> little-endian format. The bulk message header's dwLength field is a
> four-byte field described in section 6, CCID Messages.
> 
> Decode dwLength with le32_to_cpu() before using it to assemble and
> validate Bulk-OUT messages. This fixes message handling on big-endian
> hosts.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/usb/dev-smartcard-reader.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

