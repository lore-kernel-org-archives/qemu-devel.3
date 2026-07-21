Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152FDC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGTQ-0007zh-02; Tue, 21 Jul 2026 15:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGTC-0007uz-RQ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:49:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGTA-0006fD-69
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:49:38 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2T9F2548659
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G9uV8s/GUciNWoOp5vpmFdNGOKk5s6DzGgEVglGOR/c=; b=If+ICMgTPDhLSyxq
 1qYlCHcooOFz2fv6CbvScg/7MT4y4I6Bi11p1MDGCBBOTDJ+C+n5pNZwBVymIzgi
 T0l+KUSMDk9/1YX8EG+96J+vunFCpGuCvQ+D7CGanXtOZ8oj77w2QypAN3zxu1Jl
 66nMrEantTpwifybJ2ddpBO5+bcCQ4zOoUnMypFQp1wLTPtTpRwh6mY4yo8JRH0n
 cB0f3a+8LcC0jn5ueN4TdEo4aoSXiiNedvSdkiAixKGI0sc2bvjW8RCRbFILYAPE
 6PARFe0dMKf8AVEPV5Rv3mLZChh+ZLfarVKwvse6f0aHJ6Xpg5E/8ZtQLRHWx+Aq
 Ux07jQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3jq6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:49:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso180013141cf.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784663373; x=1785268173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G9uV8s/GUciNWoOp5vpmFdNGOKk5s6DzGgEVglGOR/c=;
 b=UOo1SaUmx9iTkTbKlzV3S+cJkadCeufJf7oxp4nweEU2n1khbyTi3GogBtAOlupeGE
 bDTItrMtGZLtKXKJxTVSzmPrRswHyCdwTFtbBzkzK4D5u8P8mf1Rd93bNmKF8y/iYcx3
 3nrVjDmE+jj4dDVbrqlNUEYYjxEF+4+Tu3zho050MBltkYy5oXcfKbdx0gXmfl33tfFQ
 xFssp5TRyyO3B6DNlG9NyUUZeQTecXcTQPD3nn1xdekfr69ozZcTqZAqwrzVOoaWYE9K
 Fh9gUnv77doUAg8eVTZ7RaOciMLkqtu9Sf/6Gfto9M9SRPozyCJ9I31/5xasnGZVKxoV
 atpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784663373; x=1785268173;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G9uV8s/GUciNWoOp5vpmFdNGOKk5s6DzGgEVglGOR/c=;
 b=Dl3Hr7TGWoUbb0GCz+d9z78YxfgLkFTC7zjs4lgP5WkHy7Ge6L3oQqDKtZtuwYGtYE
 0MchdnzvlKKmWhDqdoflR4TJ5eHpt1Yxacdhx3ZfDvyQ1yqvKrwvnbJtlSkzaXjuQd/2
 NagCJtww7+dn42+z6aybAZvtcB7uUxQUeN7u5r3kVWrbpWaY4XZdo/j74DaP34OSW3MO
 BFjCNmEve3/bvebeGT9vp95ffbUaW++dU98tbKW0eknAaMnztI7aYBk+DIjFSTlRIbj1
 Cfyp7xYm20U8CpKxeeh4hxJRNxQn8fphkVc0jTv91qLciFEtq2UPc9UHWz4cckgRbxKy
 xuAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUUcyHBnNuFdKfkXKk9YjWub7yA6j2Z2HIpxVuQvKXZNygyaS4MtLfNv1zZGMz16l525mXFOOpMdck@nongnu.org
X-Gm-Message-State: AOJu0Yw6RoejpyCe+uEo5I8V7Ke3bKqOR2mC1CBJirk73TeRi49sn8Ne
 knBL1IW8F+KYtu3vOQSo1RXSDrPxwNNTjZ8Dih+mkcz9mRVCxQr+L60RldP3qj3us6ujNtMKMMu
 nh6y05Usk3OtTq12cuhAL6ObeKMHsHeX76rKmEJOZeo5GgC2VBIvPXrWB4Q==
X-Gm-Gg: AfdE7ckAty8hFaeLjhVDXom2AqWqnb0BObqn1q76y445tZc6xYpubsIR2wrc8BDPgPH
 IK4Ed71qeDnyQjd1y9dccHCxfXVUETWJ5suChgZVJdCQeOihRLftncWRGseHBazFiXLF2IzYouA
 S+MPC+CAu5hxruq9lr+OokxY2qvPew86Pc2vDHlDMmOnBnhoenIHJayIx0VbtdVuggTj2hbG2vE
 bD+YiAmWUwSwEV/5MMLPg0WsKPSNl8ER0aFcfvfQNC3pgOLBWe2CbR0J/wpFn4ANfRJ/R927IvJ
 D7snH4PUxJM5Tc2U6gJK9O6JdQ8bhU6OVIGmL+FFTKZHk049xckjrFh0XzuEKTBGrS3BNNb26+G
 x4FgGhG7PlqbTuW5bya9GbHURid5GU3O7ycM2ucy20tFoWwjQt0U=
X-Received: by 2002:ac8:5f93:0:b0:51a:8c97:fb98 with SMTP id
 d75a77b69052e-5213fc578ccmr191540911cf.65.1784663373461; 
 Tue, 21 Jul 2026 12:49:33 -0700 (PDT)
X-Received: by 2002:ac8:5f93:0:b0:51a:8c97:fb98 with SMTP id
 d75a77b69052e-5213fc578ccmr191540561cf.65.1784663373010; 
 Tue, 21 Jul 2026 12:49:33 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7f55sm36822550f8f.18.2026.07.21.12.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:49:32 -0700 (PDT)
Message-ID: <b902fab2-7d33-48c1-9fab-16867a8faac9@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 21:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 02/15] qdev: Make qdev_is_realized() take a
 const DeviceState *
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <20260721-qdev-v3-2-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-2-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNSBTYWx0ZWRfX4DtvX3uK8GcO
 ltmbVVdSm/jKbqInuStt5dpf6WSLTGkE0XcWiUVG5CW1yzncDb7Ybd+GiZ34zUOVDywgVUXnKbQ
 pPgoXUCKTg5uDs0yOEtIXC/7G48GuKCuw4hxwQt4u3TOuQb3bVeREvGkWwo+szZn5JvecsUM0K5
 eWCcwU4fOirK7Nwrf0Jk16naJqYX5eAKFvhpqfJ1I0SfLWLct+nURuAlRQ8IxWzh86a+uEBLQtY
 fks+CDdZWmECkGjDYCRsSa74Sdbo5i0lDcQ2ES0HypgXpQxqoMaOCo/9UtDh3LPGFNfhgryen04
 CFG7KmZ+ZKS4LULoxKE69SJAU5ecFZh3rbmNOVngg7LRj+57Zr42xGl4aQuaY5PKCDhWgDUHLBd
 52TDmuGEwuRA4XhxyZwO12GawYW8NekTy3Ds7metcVohhNTrQjLAusWB1fVM6VemQAJOOhSpCPV
 alTqmjhZOoaYjdBuNfQ==
X-Proofpoint-ORIG-GUID: 6WVbQYgaGTpcfxy-1Z1kr6mfFaruexZj
X-Proofpoint-GUID: 6WVbQYgaGTpcfxy-1Z1kr6mfFaruexZj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNSBTYWx0ZWRfX0Bzme/dFu4DH
 Lav6Lz2pIVFXm3MBZBeyPMFPxsA9JuGS50KyFTKhWfsadbFt3YmdbNHeuQ0Uk7oE8zNp9WMmiXG
 mgI6LYHlper1secVI1U0rjTnKjKvWgc=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5fcd4e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=dLHGZYY0-qxWrHypId8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210205
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 21/7/26 10:16, Akihiko Odaki wrote:
> qdev_is_realized() only reads DeviceState. Make its parameter const so a
> later caller with a const DeviceState * can use it.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   include/hw/core/qdev.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

