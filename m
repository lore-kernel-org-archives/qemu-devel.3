Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D147BCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXeVW-0008DN-5N; Thu, 11 Jun 2026 08:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXeVU-0008DF-Fv
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:27:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXeVS-0008HF-S1
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:27:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA1ScD168127
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H9m2xUR4o8CM53VHNf9Sq2MRp9vSmevwL/9aMxbSUdQ=; b=E9X6UOLuH0eh1rGC
 S1Bsr0A94rGmqtZOS23CT4AYFun82icNjt7LGXH8z2rZ005JA3Yk6AZVOwL7GHW/
 G13TmgkMs6LQab/2Rm4h7HWRBr0coiEiBQIb9UWrfnUy6Hg9l+CtUFsfE88gBrUM
 pXHO2i+v2HwjkAHaR5NsNNwUviHuiJAZ9BQL3iQoCPb1Z9Vb2WHIdQLwdeyIlnBX
 /R3KerAl6lH+7SNCpOEXyifGcPMr1Q8LweyqRe4NJ3bP94xT0z5jJ1YAbXbNM/Nl
 xk9NyggtN5yIPdwS1cBqEpwjI6Oap94tHjP+PfXgLmgUT1RgDP6r0Y++8qAA8ceT
 6nxn+A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ubc7h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:27:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-517e0cdf99fso45285471cf.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781180852; x=1781785652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H9m2xUR4o8CM53VHNf9Sq2MRp9vSmevwL/9aMxbSUdQ=;
 b=OBD0wTEsbDK7m433kzohvhM897GcshBNI5lHB4zgrAElkcVGqPF6PkkRGCZ737V8cD
 9DbcaRfOgmX7fmK3QhiFG7U1CZ+Wa54oH6/Cz52mYB9gJBuBFK+D0xvsXTg2+F+H2qxA
 /foR7BKn+kUUrcFZ+e4/tcIRvtxw+uiJHeO2m0wK4k1gIlKlx40TzUggEUBDL4uZ/3F6
 uy4g40Ap7mwaA9DC+rkttUyNGnBNJZ5aIb/T9rpV0TLVLAI7leCESGgILjcIEOgeoeAV
 cC/e8zN1HMJczecw27WukpKv+Q5zXfClUdfO7HZu6Lq4rKZ9LZlwqRQMaZoHS4baW36o
 9Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781180852; x=1781785652;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H9m2xUR4o8CM53VHNf9Sq2MRp9vSmevwL/9aMxbSUdQ=;
 b=nFzVC64V2vHrT/D233/tdZNGYsrqbM+mi3CUz1/X+Gj7CdYYdy+zqyJJbXH/+PamxM
 8wxR/+UDjaN3W8kPowdKv3dfA5eOdPTxuLAoPlX+pP/GiDJ0gvYtAHXckvfEjQWNmDuc
 +oDhLyXBq3X3CTo0TUUDBqrqdeSCp4ZeUBZW6qNyZAIEuuQw9TLUQr1sd3HKlOKgL1+N
 gOlQDeGtgOiVz/YWEbsOCWCmwzm5/lnMYxk/ypy5BndL9Ejujmp4ztQiIYUkKkyTLgR6
 GYGf1dFiytkVeF2NJEczeuINUZXfMGRjA+mIbF+Wi+IJ2iVVfI8bMyqvypXxVIff5r1a
 WnPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8r/ynAgzTveETtM4HCnBk6U17KENIwOBzilXMHHV1nl+1LN6aBo3YAG4bhZxRuNyXsgcC/gmq3sNB+@nongnu.org
X-Gm-Message-State: AOJu0YwuenjbCSIuW/SIQXiOtUqpq8fqLPRn4ubMZOgbsOpU0a92se5Z
 uAD5txH4lFfkq+ViJQrk7ljnfZRK0+yaPuHeTYueu7sAt26gutRsUSXTzWQ9OJRMGg4FVTP7IQd
 iazNWfYbjjTIcPyKqoFqM4MhS5+7G7pXxYjvr8rNUsCk033+NlQlkEvCt/g==
X-Gm-Gg: Acq92OHkwQ94XpvrAnmaX/hhNQtDtRexidjb6GNLmHHMlIvyY4qB8DZ/8ggQanzfB23
 aOctAU35jbodkpLHR3HzcWqdhhDxHqzz53XgJfsWTM2+7PUmvSeydtUVuHZhoP1nxmLZ+F6RTYG
 G/K8xKkBT2McBKpqcykDrKZ6nS9pmJXFgOXDCu1gLPJY818P86KS4do3wUGZNQZltQUfQUhmTrY
 /TDvZ3v0L6uLB1wJAtCWbqjnYud/bBOy2mK0ByLOwZ2pIo/cYewoJvNAxaepVF67EimhIkD0CTO
 m9nGtZfdg9PBFzsYKAd+RvEq42dv5MkJpqmo/htb7I0+VfPKkyQg9ILkxXL38Advs1FJ3WnZxdW
 13otdvSqi00Wa2SNqGNRZQwwzr3ozDqciYab0cbnqYVroECLKJSQbtcnzKzHCITGt37wYrPvq9W
 ktrGbqurU=
X-Received: by 2002:a05:622a:144:b0:517:2c1e:8b6 with SMTP id
 d75a77b69052e-517ee27e445mr39344791cf.38.1781180852317; 
 Thu, 11 Jun 2026 05:27:32 -0700 (PDT)
X-Received: by 2002:a05:622a:144:b0:517:2c1e:8b6 with SMTP id
 d75a77b69052e-517ee27e445mr39344291cf.38.1781180851770; 
 Thu, 11 Jun 2026 05:27:31 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c7ea52sm67022875e9.2.2026.06.11.05.27.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 05:27:30 -0700 (PDT)
Message-ID: <5c42a81c-e7a0-47e8-acc9-2be70c8a3380@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:27:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/28] Hexagon system emulation - Part 2/3
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, philmd@mailo.org
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfX9sWrGMM8imep
 lgDqAp5j0MqP6razRVqcTRReVjyhvbN0ihn8KigA75q+aRSbINXBhIBFfhdPxdDht/6/xbmHSdy
 QhP7PGP3a69pyT021tU16wVMmj+kNTc=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a2aa9b5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=MCic4ayNfnv8SDYzCDkA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfX6ggqH+3u2O2U
 WVcI56H3Py7qVgBg6JSFXdgSksYc+UDpV3LExTCPWQAspl66vEYZZ03umUnw12iH7xQmYGp3EJQ
 vedhh7x19b3ZctqQPvIgVv6xhFNPKdSQUybB0sMVeqtTxpCETSmH5+0KMkg7y+dgb5GTF6NdGEZ
 vuIAXLdl8IAi9pVfDC92lsgqTIJ23GrtL3D51Fa4KlHvXXh2LO7nHQCCJNyFWb3zFIYOv8dgkfE
 IDHnMjIzGmzrY8+3EKZsuOYH+xRifXzrPGGhcOORS8vq/Hpxcku9ufxM6tmV7ymQpvntcnRddZc
 umznoF4h/kP3luVCR7bWKf7GESvMySPOonYwRWEj0yMPAmSd3nT2EtrWN9cSO2AWU/XvYaBjkgO
 8QaZcdQFC52S/JGE7UMoUpIqDesyn1PgHl2tJ7KOhp7urqnzdOXj9dvG92mkeoQfbNoXshoC9tp
 jJIqmjuGlD8uuHOlDYQ==
X-Proofpoint-GUID: bTqg6RN4bwT_nuJs740T5pZ-e1XGUAIR
X-Proofpoint-ORIG-GUID: bTqg6RN4bwT_nuJs740T5pZ-e1XGUAIR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110125
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

On 11/6/26 07:32, Brian Cain wrote:
> This is Part 2 of the hexagon system emulation (sysemu) patch series,
> building on the infrastructure from Part 1 to implement the runtime
> helpers and CPU operations needed for full-system emulation.

For some reason this series is missing ordering, but is fully
reviewed AFAICT, so good to go?

