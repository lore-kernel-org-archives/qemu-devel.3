Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B3BC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0z0K-0000nn-3L; Mon, 31 Aug 2026 06:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0z0I-0000nX-JT
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:12:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0z0G-0002ox-Pa
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:12:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V9IZMX2026322
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CWAt0mmu/tEAGcuXWU8Spezu9MrmTWf9lVlbq0tNuzQ=; b=LCFoeRggV4obCfW2
 fTcJV9gue7EmhEwm2FS6G4U/WaN4TXdK6J3o7KRjODWAWTul/8htWL6yoFiOnQEZ
 0q2L8FK32s1Y2/0hWpMTIetNouQSsJmo/GDHbX5VFkLyzf4oGq6rztWaOdchV6SN
 Zkpo9LUgKew2Lp1vEh/R+HARTiRadyNzqk4LuqJbANvxROPHJlMDn8nTuNJLJnDg
 Ft5WB8kNWiYNUKp+lgGcPW+30nZqkM0emyL/33JjE3UXjheEFcCZdoQXNKT0pe7M
 ZEGdtk44wju6pfE7/YZqRo2rh3Kt+aNW/BbSonTKcEBBMAiQhkvI/JBVPXtMjcJl
 CvmhoA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6vag6tw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:12:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52fbe82672eso26829821cf.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788171153; x=1788775953; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CWAt0mmu/tEAGcuXWU8Spezu9MrmTWf9lVlbq0tNuzQ=;
 b=NIjwtG5hEZUgVDsQxTj1wIfeXUqIowmFjlr08LxqnYm3H8L9i1BBPgQ9rQpyJwfly6
 9RS1A9NIaE5F5Oikjf1Y1y1DTKQzR9ogxlNRy3pAoWAt+qDNO+hmWlmSk0Cs56cDxqae
 v6PpQqCcpyZyhexbygfO/HdgjeQzgpcSifCFTkm1XWWu5VuC9vqlYaUzsS8Cf2xK2ghJ
 JQGrfmiXQBYaPQXNLTQsTgN4gWW5o1z8xG3GvEpa8quGf9RZVfLnBw+hMyJUtmDWCRgn
 p8GtueXCpbtlKelTsZ3HAAjSPKms524brHaXPJh64kHkYmKU2tURguEIH8xNrnXIM7o5
 Q3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788171153; x=1788775953;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CWAt0mmu/tEAGcuXWU8Spezu9MrmTWf9lVlbq0tNuzQ=;
 b=GDVKziLsuJSSMIqulC75JYXVUhely5SRLGdgrMRak6fMC5U1Yw8LPsb975+bJ2+MbC
 y/80qlXOf929/pVXKdGdySmaWIZMwT2vZK/i4xKJKwREU6maP/0wsovj2CQrgF77I4s1
 36FtW+jbiFv6IP+Kw0z0BEAu3QZVRlmbjrJGt/lJROKbzLw9kb6YJpqUaN8ti0F4X7iR
 jBcPVPhdoPda23XT3CSIUJ79H/l/zXB7X4oIdBZuhQSA+BUSJykpONxa6dvseJqw5wak
 hyUnF0RiRwMDBDdFJx1H95nLxEGRWwM5ovVA62ASaAwNJEg0UHKxRV2A1Ve8G+xeTPmn
 9tUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvHcv7mxGV0yKsYCyLvXx5JkLs1IEVnasj7aVnuH9Zgsdsuc0WuugL6QVRRJY3885/S+3KDUuFsV1H@nongnu.org
X-Gm-Message-State: AFuF++nQRGoPOGmFFtYOieDwUT3IRp5m+wn4H2Lw+svfUDh3Lltd0TXu
 TBgKJPBw2dh/gQbUthPv4qkonOitMYwxIBOnWkYDI06UGLhX2HZeyBvBubROl5QoiKUiSPktXxi
 /L3yjy8wvzoZ2wWVbaiDJ8fHF7PTpdmjICyN+g9ZF/jGUgOEIcJtO4cwZSw==
X-Gm-Gg: AR+sD13UqkjVWrY6KBkb/jVXvN+nP3t9bNpVoAQK63XoH/kQcklfbcV7fQH085lqc8G
 NyCCMDiT3XrL7l81cZxciCg8THw2dVNFw0epRG7BkXeHAbXZ1Q9b1yWTjKXITvXU0cYfO5Pgoqn
 DYj1PPQGqDWuSbBRU4Cysm21C7hIXvqn1qFRW0VO30sr0KpwpoIGtb0Jvc/OWzqsHbnlxbhzplD
 XSTo6oxqEHmnmPZH+ghUyHMe7b9H4hQY55KgTcJi0O3UZMrnHcztMPY2JBZ38w/h6CG6OCBk8jJ
 JAxxL52MaeVrqQZsOxaKNpwK91DezkEuhrBPS/a07Wki4XSkLzVf/RHSykvueQAeMylhz6lKcOe
 1m0BUERF8pPVVvR6op3cKOEeK+i+zjsc/Hg==
X-Received: by 2002:a05:620a:2907:b0:939:df7:6ce3 with SMTP id
 af79cd13be357-9391390b4c1mr2584160385a.26.1788171153284; 
 Mon, 31 Aug 2026 03:12:33 -0700 (PDT)
X-Received: by 2002:a05:620a:2907:b0:939:df7:6ce3 with SMTP id
 af79cd13be357-9391390b4c1mr2584155185a.26.1788171152887; 
 Mon, 31 Aug 2026 03:12:32 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dd2517sm280077395e9.7.2026.08.31.03.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 03:12:31 -0700 (PDT)
Message-ID: <2e826f6e-28be-4a2e-ba20-725b293d24d7@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 12:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call tomorrow - agenda items?
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <877bl6eoqv.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <877bl6eoqv.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4OCBTYWx0ZWRfXzrXB4FpVq0PV
 WDM4MmHIfFpHRu9R4Q4uBboDUFSraRhl1w6zBkx3VWfSd5luJrzwY9nQMlD+FuxNZ86jsUBOzxP
 nqklPm/nAluKRmofUKb8jGPyYIEivKKegFryPN8oYPxsz+bzR9BFqvOKmlrvoWEhZlRR0fjhUpO
 bGH5Zr8cHsPu6BjLwFa/194G2lm61EgAGFAJ1sRDVX3vRgnfeqkKmxRSURHh7XETFsk0Ur7KlBl
 mVgnKvBIXWLfZXLVVY26zIeUhDbmJjBB8VCkftyeQxyr4kLhyyNmInJxVPB8Hkylv4UDqgWCawy
 Xv+iR486QcUIuuqWjzEJJAdvR3xUSUD+OXf36/NOnXGaWWWj8Mxm5z8PrCHMT4S4w1M7d7MHh7E
 XL1SSGpDRBlN7pH5p/g1MGJmv7BPQuThhMvOR/qFmGWBrKND3NueX/ELT2zOWiPsBw/KYQCXRLd
 CTrLNSj2M0lplYb+z3w==
X-Authority-Analysis: v=2.4 cv=YYmNIQRf c=1 sm=1 tr=0 ts=6a955392 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=nXA5WNwiAAAA:8 a=hOcFSy5rXEeZKB3ONToA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=fGr-7aqQv4RST94IA8XU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4OCBTYWx0ZWRfX/Soo2jpamUUg
 7mdryUyr08EUpJ6sQs4bPiVa42/ex1RD59wzkvN2o8yauYIfvrXvS4cE5NytS77NXyFOIvtQp6W
 pFQj0Wvd0zR8RSqz/++T2PpixT/5+gI=
X-Proofpoint-GUID: AdAqV0mR7_QDTb5vuK_Mxa3iDmHFKSys
X-Proofpoint-ORIG-GUID: AdAqV0mR7_QDTb5vuK_Mxa3iDmHFKSys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310088
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

On 31/8/26 09:24, Alex BennÃ©e wrote:
> 
> Hi,
> 
> The KVM/QEMU community call is at:
> 
> https://meet.jit.si/kvmcallmeeting
> @
> 01/09/2026 14:00 UTC
> 
> Are there any agenda items for the sync-up?

Mark suggested 2 topics but I can only remember one of them:

- How to merge a series what touch many subsystems and which is
   mostly reviewed but few maintainers are not responding

Maybe the other one is about merging experiments?

