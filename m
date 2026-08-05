Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986D2C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrZTc-0003aF-7A; Wed, 05 Aug 2026 07:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrZTa-0003Zn-C6
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:07:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrZTY-0001IG-Ej
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:07:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6758dd2e2669675
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 11:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jw8xM70P0eRyAhL5m9nbXh24sHnFxgD2yr/z+IhESp0=; b=IbJVui30Lc0Vz3se
 zmSSDYuya8q2UgqIz3bvdXNkA/udWVrSinnzMaOCjj93vY2Fhileq60Tj8YGrZQv
 vexqiFKbWYUPx0S329fVwg2Z7g3T1CQGjTfKzoaWF56UpXyWcqxlw19YrCX9sLYZ
 ZmdDqegBJ4S4liaS0+MPLc8eejxbUtpev9qlkqxlT/VNzA15ZMCtWS3vHwkgY7rP
 UY45LQLQE/W3X2iWxbTFJLny9W+SaSGqd+YS8CXzwihWWkafBkWSGua4sk5rGcmM
 4du45lJpaCosoV/FLa+lWA4/AGb5m7bvsDDxBKQwt9gDb92ZoLLm6YATIYq+sWcx
 bb2X7A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3qc92b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 11:07:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52ce64c41efso14051051cf.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 04:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785928074; x=1786532874; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jw8xM70P0eRyAhL5m9nbXh24sHnFxgD2yr/z+IhESp0=;
 b=ImaJyTIK/HCkBIVLWmjzQjotQaTmqThblPoh3riWHYorShW/ewPby9mUwXfPCsMZck
 Oz38DafSBYr5P39eYcFMQsJnJ+rSNoefqHs5Z32c1dwZInU9W0ZuRIx6iU6Mb1zHh2Ak
 3wG3Pp4hMihCs7Vj0Znxfsm5mbwDE9xuMo73aXY99yQKKqaXNFy12ljI7qZ+9OFtaYvo
 SYQktSYh0fLiBscKq5T3Ktv96lwPrgWfUZqcI3Yp2e5C5XYlw1Pj35OEYHidHX7WWpwN
 G9rLfppCN67B5rh5iP7Qf95sMfBavLSmUOkhlkyDRiPR4ykwy9DSUeJQedhgEEoBTWuO
 R70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785928074; x=1786532874;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jw8xM70P0eRyAhL5m9nbXh24sHnFxgD2yr/z+IhESp0=;
 b=MZR2e5wku9peTp3f1xsOaD8CSKtdZSWwoBe8ddIIG3NBTIEe1JtS5MD0rnNd5oZDY0
 3erxLxHYS6CIO8K7ZNWLolQmdBlIZJEQQ93wZ8HvzVa9TFvRq8gD9Qc6SD9ZTJQquwo9
 rGd/m+mp7NDaU6LyZ0ExzEwKJT37WR1Znqh3pCjdssYQ1a/R5fPOEyBMLuJfiMzIYMB4
 drIM6tq+TE58hyYWMmLJanLOcy+eUdl0Bp3PzeH7dwcrLxrLbaZLQqDrPlbkzdT/OhEu
 DdIhJldFW/vystw+yYqxMsSM6fhqIMtNYgsiDtaVxeHS2NS96TGcaRE7WO9yS6uNZIao
 p9RQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6S7INAXryg/6Dy5qsYFsHX1RDAfmNF/l18ch3CsO0WvSoRBtPXA++CdE2tFvvg0PxT/2WrwTynu7u@nongnu.org
X-Gm-Message-State: AOJu0YzuL1qG1qERri2LXqol9lJNVNHe/IXE7MSSsn5jC32efAIwqXyL
 3Ag6rLHknaZqK7f4tUPosh3WPyoldqYN8u10Wltx4b0L9Aq6ttOlnkVGvwB0+11GSJ9WcBllfag
 MkXkGkFfa/0A17lkh253bTz+GcBETlz6nZ8iDuv33bWOgqJLZMWCMkvdsBg==
X-Gm-Gg: AR+sD129O48e0zLwUqfwADodHmyZz+za4v19jP5ADtgqche1pYorjk4nC0md8g04gSf
 bnxSvrfflxQIM7glrbd6IjWKa6oB64sNtoyx+3JXSvKOLVVytEnbTomZZBVaQaGywwYvM+KsQHU
 yAivWtTXUV5sIjca1Wy6jaTvZc0FHKqdejS9nvRccLVN55SYrnPBORiG8VJsnqGLmOw9/Ss7QLK
 QaT5AmdmbcSFgJAYSIDvmoEjD/5eBgi4lu5YSvzPT6ztWqE3tARD4jziO/ZzDtktbvkbeQ6DGJa
 zN06rJJsoMHfHCQQOqJMHuo3xMI0HlIiICpEVgknoh6jxSf8j6IQmv6wZnk0id/YuqVNlXWF9km
 I9FrXT/ZURHfANK0PldNUHKLTRrShkXhfdEU=
X-Received: by 2002:a05:622a:5516:b0:51c:f8f:13e with SMTP id
 d75a77b69052e-52ce61eebe0mr63901271cf.40.1785928073928; 
 Wed, 05 Aug 2026 04:07:53 -0700 (PDT)
X-Received: by 2002:a05:622a:5516:b0:51c:f8f:13e with SMTP id
 d75a77b69052e-52ce61eebe0mr63900901cf.40.1785928073450; 
 Wed, 05 Aug 2026 04:07:53 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fcb46esm193880675e9.5.2026.08.05.04.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 04:07:52 -0700 (PDT)
Message-ID: <501df67e-28d0-4630-b98a-769abb41086b@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 13:07:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host/pnv_phb4: fix guest-triggerable abort on
 8-byte config access
Content-Language: en-US
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: qemu-stable@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com
References: <20260805090530.1333997-1-nikhilks@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260805090530.1333997-1-nikhilks@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4OCBTYWx0ZWRfX8wDf92Zc80Dd
 9/K8YK397IwfCmzDTLOR/3m82L5+QEQyBgznHbXprGYNJ14+3xfyyhG9CZeTdfKOg+tDmtquv+w
 T0t8u1yFk9oCnUs5Y7dd2DBz5IbP6tyFo0c869Zcv3z2P4ixgMsm8orfMyv28KZ012/IcHx9i5q
 2tdl+dpbcXuNK/PU9u74txdSku3RSMdoZEe4ZUaAr5G+I13QQ4erwHZsLE/4jqzOG1A4Sm1DQu7
 Jue/ViIEDmhjkSCDbU+lgtBt/F9uq2H+xTgIKaeR32Na6yZsQ9JyOFxIjcE1H+XfbPBzH9wR+QM
 cTw5nW2L8PYhMCQLuUM5sp1C1AYr7LNsRtBAp2Se4duyogm22o5ng0+Rzb553QK4j1lLJmL62lA
 dCF8s2AGYUAH0wK/qF5h1fiFmeHYHRUhmGIjPoY3pHlPh2spNvc2kMt93RgaRh0ZYPOw3UK/bMI
 EfHRi63I/hFIuzvhpqg==
X-Proofpoint-GUID: PCGDMFpzWRxPWI7v9LWz7ZvjyeK4TDii
X-Authority-Analysis: v=2.4 cv=LsiiDHdc c=1 sm=1 tr=0 ts=6a73198a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=F1FgJBgmQavx_I4GYRsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: PCGDMFpzWRxPWI7v9LWz7ZvjyeK4TDii
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4OCBTYWx0ZWRfXyfmDZ+qmUOtU
 KI8eL/WNWrJIGDV1VJr03nkVJcHyEw8VRghSwYaIsqdyQv30vrBWd7PchzzDWAH9UQ30niC/v21
 B0OAtOjOf1bO3Tc88R8U4VyRgG+Xzjs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050088
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

Hi,

On 5/8/26 11:05, Nikhil Kumar Singh wrote:
> A guest-triggerable assertion crash (DoS) exists in pnv_phb4_config_write()
> and pnv_phb4_config_read(). When a guest performs an 8-byte access to
> PHB_CONFIG_DATA (offset 0x130), QEMU aborts because the switch(size)
> statement in the config accessors only handles 1, 2, and 4-byte accesses,
> hitting g_assert_not_reached() in the default case.
> 
> Since guest input is untrusted, an invalid access size should not crash
> the host. Fix this by adding a size > 4 guard in pnv_phb4_reg_write() and
> pnv_phb4_reg_read() before the config accessor calls, and by replacing
> the g_assert_not_reached() in pnv_phb4_config_write() and
> pnv_phb4_config_read() with phb_error() to cover any other callers.
> Invalid reads now return ~0ull, maintaining PCI conventions.
> 
> Fixes: 4f9924c4d4cf ("ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3591
> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> ---
>   hw/pci-host/pnv_phb4.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)


> @@ -507,6 +511,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>   
>       /* Special case outbound configuration data */
>       if ((off & 0xfffc) == PHB_CONFIG_DATA) {
> +        if (size > 4) {
> +            phb_error(phb, "invalid config write size %u at 0x%"PRIx64"\n",
> +                      size, off);
> +            return;
> +        }
>           pnv_phb4_config_write(phb, off & 0x3, size, val);

Alternatively MIN(size, 4).

But without looking much at this model, I'd expect these regions to
be mapped as the usual "pci-conf-idx" / "pci-data-idx" ones (FYI see
pci_host_conf_le_ops and pci_host_data_le_ops).

Anyway my 2 cents, since this involves more of "silence that DoS".

>           return;
>       }
> @@ -644,6 +653,11 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>       uint64_t val;
>   
>       if ((off & 0xfffc) == PHB_CONFIG_DATA) {
> +        if (size > 4) {
> +            phb_error(phb, "invalid config read size %u at 0x%"PRIx64"\n",
> +                      size, off);
> +            return ~0ull;
> +        }
>           return pnv_phb4_config_read(phb, off & 0x3, size);
>       }
>   


