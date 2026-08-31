Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF9FC624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x14DJ-000644-O6; Mon, 31 Aug 2026 11:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x14DI-00063R-0g
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 11:46:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x14DG-0003m2-36
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 11:46:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VETPpu3895543
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 15:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qrenrI91tqtemJhMS4GYDVifb1QaGI4VKsg810+hiL8=; b=KFpnQNUFjQ8L4VFG
 Bz+HIByjuhAOxL7kqgEjU5a8mc7VTyl3pMtn89PudVEy5j0W+hxHmeHMSzU77tkL
 FL4oEQ6qTH0KFAIduZE95DIPrjjscM2Gg9PDozH+xS3ZWAerK8aTkWaqm8epgJ3b
 4MO/T0zUJT2sHGmH9BKFmmikS2y43YuCnJHkCrkivouCck3SRxUNSQRavFLfrV2Y
 H2EhzymidZPSlV1Juju/jS/AFc6HyNuuRWhLkROrorUYTG0ClD06Vq9xzmdiRWpr
 7v5+II75BrEykxewJyH8XOJbTGaCxdANpa04KsMdqLFoZjmLCuMMm4KPpBJbwPh3
 LQ7ykw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6rb9jnw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 15:46:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ec3146553so875128885a.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788191178; x=1788795978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qrenrI91tqtemJhMS4GYDVifb1QaGI4VKsg810+hiL8=;
 b=Sa/g03HlBe5VNI5WVj0zlmcIxoe+VdQguoBaw4dNk+XyLC/nbHk2sI0qZzlrRGBNVI
 C2ZMIY8lqgyFJffQVzWeOcKkhYN19/yGumNghtRsaDkAHlLz+pExjavW3ZOue4aV9lm0
 KbFquQ6Gh7Rmb7VyuOk0rQnw7/f10y5WyN6ElxNF0j4gyDInyf1h625B9WhGXNwae4Wn
 ImdOMMUopZ2wtZixZiAd100iwwJIuOLmoFdvUB96QfmIxg15f7OrCMOM+91YZM0ykZT/
 Cr56z34AQjiwqrCtFiJfhLUy9D4N281C6HAqug7rnnNvReP95CzxXm84m36FXlnyuFmL
 2PjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788191178; x=1788795978;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qrenrI91tqtemJhMS4GYDVifb1QaGI4VKsg810+hiL8=;
 b=nPaMPzOfyx97F+kEsqMphuxYUysOZiHE4jxgfGSLfzJxz9Mlkz8pzvU1pK1+yArsyl
 VeZ/ZDmznxU5j6DVuwMuEN3030aE2pA9QnTN6jcM3HbjvXtSs1QxrkkVeluqJQXaaEsZ
 VxnIRpWPRDEWv337PI46WbA1ryhfDHCoxtQYMP0fT9cFBzFvT9NrrAqmlHfgGvgg6LoF
 B9ipy8Du8JfDwvhZH0JaYa9MDnHDtJ+eYQiYxxMLsZY/HmBRo7ksTvJIfMeW3Ow6zpW4
 Ac7lHzDoEAxU35SaQrxlWxSOIHuUDDmq8EYGBWo+v3L2BHY8yeG+zuOIrFHNbD2NWlq0
 KoFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrW0My2FRegMZJ1W3KepiAjiHDQkofEiiUe5DzLWSHxFvf1zqyis566Xgt9FoqUxPBcw9/T1I0ug7My@nongnu.org
X-Gm-Message-State: AFuF++lydn+lfOQMbWlf+O87jy61QTMc75evE4R+C6IBQkbAOp5JzoZp
 mPeHgpzkMlh07A9hC6UF18IVlcDmkpVsvhYkL/8I9SKVcjlUYbu0i5ycAEiEBDdI0uD+N1OzRQY
 6g6KCkHqxJn92NgVu4FLwZjZWDXd5Nx6xox4uLnTGKIaGo6+wIewPOY2Bmw==
X-Gm-Gg: AR+sD136iM9wFZs+cwJ3hzU6/hpxYQi5ACeLh011L0LFO2uAzi26ljtPzJc7o8eLajk
 eSX6KQzeJV2ixH40217AnMr4PmVOdLvfkEeUDGbFLpPoHsMQJhEStEuhi6bZrRBsaS+dJYsPeGG
 sSd+NVlerBZrnCGJn5wrCovJIAF0WTHuAJTo0P2H4xVTlMpRl6xVXz2yJrCnl3TMfahg7I2X2Jj
 2Et1jHy4zh+EZR42kEyD+Jfsi20yER/GLsugFbnHDswQVZ8Gt3ZnIi/L/Zjbl2DAptsKl3M6PG0
 9xMh1G2pTnJxvPiH6eLTZBjDCqFwduj9f842m1SnPf8GlyLPJURIBvZQh5nEh6no6l0XKyHFQvY
 M2hV39zQ2ewZ4yYlEp9VtLU2FurOCtqtnDA==
X-Received: by 2002:a05:620a:458a:b0:939:3696:6509 with SMTP id
 af79cd13be357-93936967122mr1020498885a.0.1788191177958; 
 Mon, 31 Aug 2026 08:46:17 -0700 (PDT)
X-Received: by 2002:a05:620a:458a:b0:939:3696:6509 with SMTP id
 af79cd13be357-93936967122mr1020467485a.0.1788191175580; 
 Mon, 31 Aug 2026 08:46:15 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b926874fdsm295281255e9.4.2026.08.31.08.46.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 08:46:14 -0700 (PDT)
Message-ID: <48cef34d-18c1-4b8c-a75d-19d1d1321634@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 17:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call tomorrow - agenda items?
Content-Language: en-US
To: BillXiang <xiangwencheng@lanxincomputing.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, cw@f00f.org,
 dbarboza@qti.qualcomm.com, Demi Marie Obenour <demiobenour@gmail.com>,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>,
 eblot@rivosinc.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 jacob.oursland@gmail.com, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 utsingh@redhat.com, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 peterx@redhat.com
References: <877bl6eoqv.fsf@draig.linaro.org>
 <413b9ba2-20cf-4af6-9998-be46da277c84@lanxincomputing.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <413b9ba2-20cf-4af6-9998-be46da277c84@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mbSYawh1LJvqy78UnRW8A_Q4Eppu4o6N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzNSBTYWx0ZWRfX5ErXuXQjBUDP
 h0wqZ8d0dXu5pieNkzAEEyyueL9Po7B7vXzJv63KAdF4liSTEeETB4sbIEB4/xTTZoDe8OQU6tl
 G66D6AQ7Gqv17gIT+ztEVpwB3x8/0CtbQmto17MHv0ZZm5dX3UtYj7OrGHoCXpmV1t8QSFxBghf
 BsBD74f4C7QzyZii2UxzaksoSpCamyrojVuNA/d85K45kF8vYfdlKoOlL5WBzia/U5M/Yxr5TLc
 DE8zRQsU7gJBGIERsi9W+ggze+DZ/+/airqe1t+3lExNZnUcqQZ8BeKTIO9hHTdDt15QOJiTjnj
 Ad+tVle43yWCGWkU/O3uaTS+w9tXP8r7RgQbrdS4eD929lajdJKQsOnXWwiV38LC324AAFPHx+F
 fIzLIcqGVSPgaftO/keeAnWpBZoXiWCp6RZTyjMftycmm8x1SmzNxKdOaizQZ1V59EW5OANy4CD
 0XVOG7vl4/5y9J38ETw==
X-Proofpoint-GUID: mbSYawh1LJvqy78UnRW8A_Q4Eppu4o6N
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzNSBTYWx0ZWRfX06q6FiBN/cHn
 b3RGbs3nvUMjbOr7ESWQaAolfaAtxM66TEuxKIPz4RF5hIFeCJy2iuXQwHgNxDqqfw8icoVDn9D
 yEX0XpALT79wE3L82S0sOrTnwjM0Dss=
X-Authority-Analysis: v=2.4 cv=d/fFDxjE c=1 sm=1 tr=0 ts=6a95a1cb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=RJW7u8JZm8_-9JpRUZEA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310135
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 31/8/26 13:49, BillXiang wrote:

> How about discussing the patch[1]:
> "virtio: Add aligned ld/st accessors for vring".
> 
> As pointed out in the patch, this has been a long-standing issue. It is
> now necessary to introduce atomic accessors for fields that require
> atomicity, such as the avail_idx field in virtio. This support is
> especially crucial for architectures like RISC-V, which do not natively
> support misaligned memory accesses.
> 
> I'm particularly eager to receive more suggestions for it.

This is a very technical topic, not sure if the community call will
be a better place than the mailing list, in particular if no virtio /
atomic expert developers appears. We'll see :)

