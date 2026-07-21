Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8206AC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGsI-0004yh-1J; Tue, 21 Jul 2026 16:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGsC-0004sk-DI
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 16:15:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGs9-0003Dn-KB
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 16:15:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LHRX0M1926690
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 20:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 We5DuZ6V6TnuJjY9VdsMK+w/90vNGZmBBsZZPL1T8KY=; b=nXHEoM8dqsmgZg2h
 Ma3bpw3so/u715lsp97yHbZWIWjMXjPbOmY933kVUsN0f+FqP5duv0U2tyIuJUdj
 nEMqCcRJz7ozCemeE42pWBkMDHhxt2icX9M9QA3Lr8NJrdiCqZFtjRZDQBYYfGlD
 gaYNzknAF9tjxxmkBuKp9exZpSPrItxrPDPExNYcTGa3nPMPH2dfdpVQYU6BvQvS
 +RiotY8Gs4wig57aKtnSC7LJWT0uCQ6j9dNHmcPGIBYcug+gC/+A1Nfh5aIu/qno
 86D1sWM3LnYdEAJm16ZjtzwonCrVxS6uIXNN9j2wLBUKw0Fnyk0AhIl93EjA2ylQ
 fCjLyg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6frqv0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 20:15:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0e702df8so173841471cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784664922; x=1785269722; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=We5DuZ6V6TnuJjY9VdsMK+w/90vNGZmBBsZZPL1T8KY=;
 b=XZ0mXjUgLOwtLV4JQoZiiAoMpzsNZXapvJEwm1yVKiwRSu+u171dF9r8uWFbdCaxwz
 qYRsaGKeacYgM/763OH8BVs9bat5iWVJDMobDxDsLZjJXBM3qPAbPYtcqRx6xnrSlpA4
 aL1LMA81DTYeqyGBP1h2HHJOsOubuXJ8c2xu9jFkhlD8azpDy2WOUCE8uYkcPfHvWl/r
 GzPX4x7RtB22E9zmu+AhC6uyA5mcDAw9FFeXPysxSy8gL6BRL6JRyVIkhQUQdK5l26Fw
 uOH9C6+16Hj2KSbt3pQJ+ibKMCX0qAeU2I2zkJ1WipuTvYtf38lOgFtpHIDvlVMn/rfS
 25kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784664922; x=1785269722;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=We5DuZ6V6TnuJjY9VdsMK+w/90vNGZmBBsZZPL1T8KY=;
 b=kr2EniryUAdqgU/qBCmdXl/zDNh2SDmTGZoWR5abQr3jm2Xth6P3O48QE0Wzh+NjTM
 h5acAeK2iCIEvH56bQr1xnnKYf7CCnUmImMsELVm35gcfxtDyfrz2Zh/t3aMNfFHd7vo
 oNMjRixeQQC7nyywIGPr2bEdRkUXNcoYc3/2/OYxcoBq+zVgnsfRG04qybZNpB+rxOxZ
 HNjEoM4JQMRcniWB3uDZ0BfoVmebPizUCTGSWbPl08VUSes9g41IFTsbLWzY0SRVBXuv
 8zXUH8/XlLJQrH8fykkOmpfDIsTRDiP1oQt2IX3oxgvGHXHTOn4sZ1cQNmGs010GymR+
 2k0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqjds82W9QHo+kpY2H+KSDm5mxpnqIRc6Gjzs4lrmRlaLF9fGrpwRKopit++rLeoqetc+84UBwfT1/1@nongnu.org
X-Gm-Message-State: AOJu0Yzkk/wAnQxxrADASyhZ0pOnex38ApfctGmJA6IknCpA3y2mGzvl
 tNXPI2Oy97UwWsc78976+C/8E+kbRybqFqMns7vIs6/zPxMZ+76r5zuppArUDnqHrIXVpogXK5g
 5ehNM2LGo3dimGYQlJirOxJrRBGCqYRUS5LRcSefjRZkYzln6ndaRRDqVXA==
X-Gm-Gg: AfdE7ckLCFJm7JQ1CQahoxsrJiKELXLjlNl00IhITL+JZgCxpAGinBcqpoMKVGcyp8d
 GZOBvwiD5JGtYhdL0znJlgOd8A7qeB5Kr41vsvJcCuRXPikPY3RMjFg7FAhm4XXJPYw3cXY+OLv
 fw0WF+m7pLRIRbdjzObEhdTTVK/uvurbGs+qdJPVYspszokkb4n++VO5hUXajbeM8CKJB2Min/q
 yyFMmQIwFdOGSarmhU+BbaRdzEDg63sFvsZcUuxlAXvC58JIkHsWwohepBfN3CXpTsTI1nfOAIE
 VmNmeZQbKXmnAZy5x6Fc6qaRY9T6il3uJ92JPGb6CtTn50Rc9gghcYy1YSHRcUokeVWpGr7Tabe
 BQd1W3lXCmapWKndcuzDL7vi/AnuYdGE9t2dDOmYHkJic3jhNA+Y=
X-Received: by 2002:a05:622a:4106:b0:51b:efe9:27c0 with SMTP id
 d75a77b69052e-5213ed6fef6mr173135731cf.71.1784664921878; 
 Tue, 21 Jul 2026 13:15:21 -0700 (PDT)
X-Received: by 2002:a05:622a:4106:b0:51b:efe9:27c0 with SMTP id
 d75a77b69052e-5213ed6fef6mr173135151cf.71.1784664921354; 
 Tue, 21 Jul 2026 13:15:21 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm47076475f8f.11.2026.07.21.13.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 13:15:20 -0700 (PDT)
Message-ID: <cc93fa59-deeb-4c97-972e-b47fc5da5c8c@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 22:15:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 14/15] hw/qdev: Parent device before setting
 parent bus
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
 <20260721-qdev-v3-14-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-14-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1KKgFME0jrgk_vzYqbt3RbouMzg2-SCv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIxMCBTYWx0ZWRfXxc1VIzXcFY/X
 B3G4KVxr45T9oH6vzDvruTxbzshN6Jgo+5lnGFbr7AlvOp2CVfjRcqvmk/lNefG8eaOAiHHQWPo
 09lP3Cxf6I/voRVrDJs1ZS9u3efSN75H/8B0fEokBhhYnZK/Lr9hzA8gRwoSNrqmqB1QIOhGdDH
 bb+G31N4oHT/k3hJaVT78LTODmSltTUAnU2F4ypd/7YaoYzsiqLfEhdmwqNAhlNSyH/XksRo5XA
 W/rXuYLQhPgwSyz2DCrIF643/QtkgcEowihEG628hSe2fFVYXyPpXFVAuG3+gtgCxvz5qn+sCG7
 rykt9RwLNUhCLWoggRUcOlwvuV1SmcZ5dlNKnH7YVdlf9YHP27t1v7jJHzdfpd7ttSUyUSSjSVA
 a6CNo7XMzDBJyg3bWfGm0chS76Yk4tAEIO6y9etTsn0neaVHERL6NlgSXzHRbhCXvoIvYr2wLpJ
 R1pt+BV1Jc0fohq4rBA==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a5fd35b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=fgZSBK4kzu8o4Ek6pjwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 1KKgFME0jrgk_vzYqbt3RbouMzg2-SCv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIxMCBTYWx0ZWRfX/ItsFNmZPdqS
 wddwT1a+6VNruChSZvtfej64drcZKwpbBZAuOmFB9N/QG0x284VSInaY8ea0zU3cFW43wGRi9+y
 AcjJXu51n1LoV9l85Bb1NMNogHFhACA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210210
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

On 21/7/26 10:17, Akihiko Odaki wrote:
> Commit 9940b2cfbc05 ("qdev: New qdev_new(), qdev_realize(), etc.") says
> "device state 'no QOM parent, but plugged into bus' is dangerous". In
> such a case, unrealizing the bus will hang in bus_unparent():
> 
>      while ((kid = QTAILQ_FIRST(&bus->children)) != NULL) {
>          DeviceState *dev = kid->child;
>          object_unparent(OBJECT(dev));
>      }
> 
> object_unparent() does nothing when its argument has no QOM parent,
> and the loop spins forever.
> 
> However, that commit did not completely eliminate such a situation.
> When the device is not parented, device_set_realized() lets
> /machine/unattached parent it, but it happens after setting parent bus.
> Therefore, any failure between the two operations can leave the device
> in a dangerous state.
> 
> qdev_realize() at least asserts that the device is not already realized
> and prevents one realization failure pattern, but it is not
> comprehensive. Besides, it will trip with a command line like the
> following:
> 
>      qemu-system-x86_64 -M none -nodefaults -nographic \
>          -device ipmi-bmc-sim,realized=on
> 
> Eliminate the dangerous state by ensuring that the device is parented
> before calling qdev_set_parent_bus(). Also, stop asserting that the
> device is not already realized in qdev_realize(); it is broken and
> no longer serves any purpose.
> 
> Fixes: 9940b2cfbc05 ("qdev: New qdev_new(), qdev_realize(), etc.")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/core/qdev.c         | 51 ++++++++++++++++++++++++++++----------------------
>   tests/unit/test-qdev.c | 13 +++++++++++++
>   2 files changed, 42 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

