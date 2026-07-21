Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623ADC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBsl-00057R-Kj; Tue, 21 Jul 2026 10:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmBsi-00057D-98
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:55:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmBsg-0002pG-2T
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:55:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDg5EK1958702
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 14:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 trD5ykvDUHe6tjXSLEiu67ZGqhfv5qMhlhfETzX91nk=; b=ecSbFUiHAdOoqL+9
 I2mNL0gwu9cp4JqXxWFgqa4FY41alqnwl1AA4HzopqAg7N19mdH8aZYD0iFnCoLR
 MrISbEhl8H5ZhQwZ/g7tVFL/gG4G0ar4IYEfZyvuf7zf8uoVFJzR6+ViSZQ+otKF
 LXFwGK8pbd7tOpLUE7gG7HWmA8VoFHWUKt/3emahjdnn0LrUUpA5genmfKgOegJR
 ccx0BMQiW1P7hT63UhyZW2Of/dYqHJgsVypiNhbQv1oQ0yzaM+iJxWkguqyVxi/F
 0rN8rFb8M6OagMbqAalBad8fk9WjxH8M4eao4iJnoF/aUEndlcuLF6bFWXjD6Quo
 Mw38Bw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1bvu22u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 14:55:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so232018541cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784645735; x=1785250535; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=trD5ykvDUHe6tjXSLEiu67ZGqhfv5qMhlhfETzX91nk=;
 b=Vw4SmaOXU1FxoVNydbAi4UldX0FBtuIW695QtLfATFbk3QrwMIu5nm9IxyPQM+6DUW
 n3dIuaCA26eG7BEXnc5kPwPhyQ0FV/ywjWiqpL0wpeVd9mwQvJ5NgDSbiQLaRVV+OOP7
 3eQYgKxCn/oqtcgxfP6D8JO5wxnX3C1j8Vj2hn+hCMaVNI36Kdpa4wzrD49LU/OfpIu0
 ZTQ30f56TvMPqfam9I9iGBYkiT0e5TrmRzBad0Q7WopnfXT+dxAOsTtDMTNsdEHLIZIN
 SvEEprk6WFvgiTn2KB8tieP1vjVuy7dRbMhPN+8hOvdJgTMTL5yzaEsvOuz9SpjUaV7D
 kSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784645735; x=1785250535;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=trD5ykvDUHe6tjXSLEiu67ZGqhfv5qMhlhfETzX91nk=;
 b=kz9ZLd9mny3yimIBshwMPbaCBDiATtyj/nqED9O+dGdWvuozkRTkhxY8mq7qGWfXOt
 6pqoZos2HDuY7F2IBpj7w0VLuTU5alTgLOSLT3HJpr47/bHrJcC8qP8DbCMHkrokQEEq
 vR8QdYR05RDcr+6Ew2FUhkntZISsYWInBreUGPZ6YfIZp12RmJfOBxPjZWpV7ziT9vbb
 jHdkaHyYm2HGGlxbHzFSf4euX5MzgGlr9iP6rWm5jxPaXXAH91NzfWGcac23pnsIalW2
 u0sS8LSZr/ZnEgpRhu/eNFAltSeqCp4JzIYbKfB7rHiyj8EOqTPnWHUaUsjmBMs/xJTm
 WoQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpw2Yfd84luCBJxEf20nWUBxLvlC48YyXSoo/K2KaFAHslrHif3ME0xAJMyBvBsL0mG1gAHhaR8o7MM@nongnu.org
X-Gm-Message-State: AOJu0YwGLEQACYGTx61NJEYWQQzHxU/Sp7gorJMgsPe5ekvvV/OMWPr9
 KG9HaVz708nPBo894f1gwjhcD+fAakZM/jowrlaE7LRPsvZkrVLvQDxGQqZuhF8zK82eOFPaLy1
 LSCNHajzjIkkWabmPAH2MCqSoPHgNRpNJg76jdgCmJt7t+0fvxYJuuynnBg==
X-Gm-Gg: AfdE7clLgA8h4d/xs/xH4CRnPIpEIIFXHd+sPyRpTIrKLNHnXXCqQMmqR/5qMP/GwVu
 PFq6UbFoivHlOAG0F/m69fVJBPRhIFarL5ofpnr9EE16zd6UeREaldHlNTYCB/CGTfv8eXRhaTA
 wleUUX6TPxV1HanHV3jXfBhBEYi4QxqYfNWTQUsqMxJdohMhdi0BhA6ulFkOPGel3cal/YFXBzn
 UF+umyYf1LOMB0w8/eXpgGBS1Niyk2UOFUgwkwLaMm8ZqRUnHOGU1v/4P1UxBMxl/pfHunQNQOY
 ruIN44x/l07F5JYJbaJtFIB6bu03joEZeCnL5t39NpXEpeT5NkctZ6b3GqRruJ0jyHhVlHimXu0
 a21Ea9pqa5oA1j/UdkC5V4KN/tiyF+j98IgVUf0TnrVgmJr9kH58=
X-Received: by 2002:ac8:59d2:0:b0:51c:7b12:5ff2 with SMTP id
 d75a77b69052e-5213d7a6561mr167296231cf.78.1784645734206; 
 Tue, 21 Jul 2026 07:55:34 -0700 (PDT)
X-Received: by 2002:ac8:59d2:0:b0:51c:7b12:5ff2 with SMTP id
 d75a77b69052e-5213d7a6561mr167294881cf.78.1784645732603; 
 Tue, 21 Jul 2026 07:55:32 -0700 (PDT)
Received: from [10.131.142.220] (220.171.88.92.rev.sfr.net. [92.88.171.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c98ebsm67684665e9.13.2026.07.21.07.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 07:55:31 -0700 (PDT)
Message-ID: <0b216681-c56f-474c-834f-2a035a728e6f@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call agenda items and host request
Content-Language: en-US
To: Mark Burton <MBURTON@QTI.QUALCOMM.COM>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, "cjia@nvidia.com"
 <cjia@nvidia.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "cw@f00f.org" <cw@f00f.org>, Daniel Barboza <dbarboza@qti.qualcomm.com>,
 Demi Marie Obenour <demiobenour@gmail.com>,
 "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>, Eric Blake
 <eblake@redhat.com>, "eblot@rivosinc.com" <eblot@rivosinc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, "felipe@nutanix.com"
 <felipe@nutanix.com>,
 "helge.deller@googlemail.com" <helge.deller@googlemail.com>,
 Alyssa Ross <hi@alyssa.is>, "iggy@theiggy.com" <iggy@theiggy.com>,
 Warner Losh <imp@bsdimp.com>,
 "jacob.oursland@gmail.com" <jacob.oursland@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
 <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 "matthieu@minio.io" <matthieu@minio.io>,
 Max Chou <max.chou@sifive.com>, "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 "utsingh@redhat.com" <utsingh@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, "z.huo@139.com" <z.huo@139.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>
References: <87v7aag722.fsf@draig.linaro.org>
 <E81AEF88-70FD-4800-A51D-2274D5BC78F0@qti.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <E81AEF88-70FD-4800-A51D-2274D5BC78F0@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pCp3D879OvdXt4YQPfnV4zFLgf4UuubE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1NiBTYWx0ZWRfXzfHy7cqYgGkV
 t/lIlQxwpkYSosnYJ6wsuZt+xKB0YAk00xdw4duhJ2JsaS8AnNkwChB7QonKB8cAUwerNIq9BWv
 xxWHjYN55HFq3kmZUaUMZpV58WZ2eF8=
X-Proofpoint-GUID: pCp3D879OvdXt4YQPfnV4zFLgf4UuubE
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a5f8868 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=HvFMDRKYglX6yPpWI6gtsw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=nXA5WNwiAAAA:8 a=KKAkSRfTAAAA:8 a=PeyiDqkVuyXktWlyK2gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=fGr-7aqQv4RST94IA8XU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1NiBTYWx0ZWRfX6OEj8D0Hw7LK
 ZdG34uzwwjSJXLVxYc5eSwwxPLlwbHD/BBG7zw08qvtNogWcqP2WRqq1TfquAXbvEIb5XX+B/Tp
 jHCyMTJjTBXfUcqYvw5LM44u5svqjJ/KrS+7wbBa5O9g4enxvISPAo8uJ5mrUfXQ7oyqFJH3sgf
 2auwCr/5HNp4tJgtU4Z2EqOEjlZgFq8wf6lyniVDdPOx/UuGEgRzBE6SDzzqp3S2cUEoQWM2X7A
 HYq0RxGRxqqbixwtsRsCtfyjbjNZOFYTbw2YT7xfgd0EChU/+NszNUJmgNIF4OsE70ejrSn2E5Q
 upJ22fqKFFT+qIF8Ya2A/gcsEzBBzgPwjsAuKSdCkM1aOLHA5/1VKdNLWkEujxNO63+K4Dt7dDd
 ZtbJvYx+L5Ke152DwLYUmY5hXZFf2A8ww+12OSO1sKwAqJEXxFehjC5BJMzjfH0laH+9ADT3U7r
 PYd5XVexj0n3ODM5LqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210156
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

On 21/7/26 16:09, Mark Burton wrote:
> Not enough people were available for the call, so we canceled for today, lets start again when people are back from vacations,

Personally I was stuck at "waiting for the host to start the meeting", 
maybe I didn't wait enough :)

> 
> Cheers
> Mark.
> 
> 
>> On 19 Jul 2026, at 20:36, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
>>
>> Hi,
>>
>> The KVM/QEMU community call is at:
>>
>> https://meet.jit.si/kvmcallmeeting
>> @
>> 21/07/2026 14:00 UTC
>>
>> However I will be unavailable so my first request is for a volunteer to
>> run the call (and record it). If we have a volunteer then are there any
>> agenda items for the sync-up?
>>
>> --
>> Alex Bennée
>> Virtualisation Tech Lead @ Linaro
> 


