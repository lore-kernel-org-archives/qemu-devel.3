Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60CFC98318
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 10:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAPOx-0001jE-FC; Sat, 26 Sep 2026 06:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAPOv-0001gm-Hq
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 06:13:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAPOs-0004Ac-Us
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 06:13:01 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68Q6OVkO1949663
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 10:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3e3+Fez19eofA4GqzTbGQxOkPf0gXUROii0eFYr63SQ=; b=ps500bUfkBD7hxMF
 ND66irYe5yV4+K1/oFKMh68gyshLTEhCaxKQOd+CuymfuMigFqvom7t83XpM3dVo
 o7qk49XBYOsv91Ic7UsFZ1nA6Cjmd7EVRYEWlq4HcpsMlR0kpMBYBAAwCPk+lFwV
 c4PkhbEyjwxVdQByaOrfzMfTSddenAWKNg/5YeM+2BhOVs/+W2wDsMLenPWJmHun
 c2sPo60vUtc+aU2XChb4gBR6042vhmqozF6lHzgd65x/jf9m376koyB4lc+oX6Rj
 hljNAflbXPFTkrrACCoUjMsfh+yhfUmDC0NaJD+qCneYlQewHckWQXRw5iCbvPZO
 gePJYA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jrgnw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 10:12:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91430af782dso32918096d6.2
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 03:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790417575; x=1791022375; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3e3+Fez19eofA4GqzTbGQxOkPf0gXUROii0eFYr63SQ=;
 b=N1kUe5C0zLWcIuaqLtrtiqTXYVdJI3GPAxv+T9DYDKeUvfMVfIEU+0tF99vLEhtNw4
 UvhjfSGSaMUzOLgVf9eGUUJ2WnmzyfUMJTpymASRDjSw2r6TCkMOvVqH5tSnEjmobDI+
 wrNo5dSKtp/A8zMNJptaLyqUmb5CoCFrUjMH+VIdQ9u0fBvUEBKf4eHLXHnDjuoqQfo/
 9lCYYjfJiGvyIzCVUPDW38UZ4bXlYB+GIAf+qffUsv9nTVtDGZDgZaVasm1LQBymvSd7
 FtTMDDv0xfFMQIJg1Neld6tmi+5VKuGJHuAYmEU8kgd3SQOVYahw9uoWIoBgsggvSSg/
 M79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790417575; x=1791022375;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3e3+Fez19eofA4GqzTbGQxOkPf0gXUROii0eFYr63SQ=;
 b=Svyoc1n1MxNh2hVmo6pLuICzHS3xMQIZKESUpyoIcQmHEulBwcH1z0W7xu1a7MksJQ
 PcXRGgIriKvPmGYkSv+f0Fg/vrCpLHMybpxmpEphNAsyMsN8uo/WaD7w+WNzX3B3arlR
 vFHx2lD0M6kB5LXj5snT1ycBjnA5toXN8npTmeVKTNlVIbyVwIWJWORYd1YpwetGEIvE
 InFiM4I38fnD9gYgMMz8fHXuOaELfxfa2yWVPXq93dwNBmsBfX1LFxzcu+bSoTHcy9DI
 HPo//6d4KU1uMpDoyV0D/lmzSOUtngxSsRjwS1iknuzgNArrCE40PZRZGzZkhlJacqwk
 1eAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5oIcxnN+//vvWuyxtLa3tWoMKpNM6MPbSm9fSi/z3y71qXsyHfU7VHJncDlEJcGRqM4FpsKk8hWtV@nongnu.org
X-Gm-Message-State: AFuF++nVEri2HTYgwiQvkhXuPKbzoZ6ur6yYebEfi1Xp3CErw8bJLWAL
 Lx7aGYmqEs64tODsNUitaRgsQFOGmD8TQShvBlW92TXXOVi9nj36jHdPEcbeKD8/VurBskerqxj
 RU50bcK3r45wb2qUYIyYpcv+nHHjvhRP7WwIeBGREF18gUrmHMaWgGheoiGkcqakYMA==
X-Gm-Gg: AYBFou1bRV+Jo2409yvBhSP3M4JSfvmjcZUC3F3hu64qyHNpeUiJ81oDOGKeg3kfRfE
 efyt9ABa1E3HnGr/cb6WuUNnw/9EVCQdytIAdB5m/QU2+EUKru1llXGvigho4x5GmMQQdk5Yqb/
 fX8cb0oJmscj4+s2h+WQuiyRroWMmEZWQVFObR8IRuUGCMLA1BfDNnK3LLNRFpMg2lJqK+/oHJT
 OobiDDB1H9tBWXhv6nb10r29qriIsH99oEmnUWgiTSLolUCbcYHSUrdrPs9huul9sF1nToqoipf
 495RIlV6XXj13RdV2PcWKhOoJUMFRrqVYHTa3h8hu9BklyvgAVjxgUn74CUNSfAPi4Kbi2K7Enz
 pNnOvC5Ow50kmjSrj2bK8iNNRpuOW2+vn5w==
X-Received: by 2002:a05:620a:19a8:b0:939:a199:45b4 with SMTP id
 af79cd13be357-93c43cd3c45mr982211285a.39.1790417574715; 
 Sat, 26 Sep 2026 03:12:54 -0700 (PDT)
X-Received: by 2002:a05:620a:19a8:b0:939:a199:45b4 with SMTP id
 af79cd13be357-93c43cd3c45mr982208785a.39.1790417574202; 
 Sat, 26 Sep 2026 03:12:54 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a355d96sm14132414f8f.17.2026.09.26.03.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2026 03:12:53 -0700 (PDT)
Message-ID: <bdfbdd6f-afae-46ea-9de4-70191b9e42a3@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 12:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-bridge: honour CONFIG_CXL in PXB
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20260922115613.1926083-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260922115613.1926083-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA0MCBTYWx0ZWRfX10in4Ftirlg9
 EUJf/FNM9WFeZhvXzwA8JA7b03a3YNozbQhQLH/+jBw4+HCGB9U2ffhS6jGjnlLI9cJK+LiHNAl
 VdySJoKC/ona3sUq6d/LqokQ/moIFxk=
X-Proofpoint-GUID: gYoPoeivPynuIbORdkEWyuq9pN7OedVn
X-Proofpoint-ORIG-GUID: gYoPoeivPynuIbORdkEWyuq9pN7OedVn
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab79aa7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=VltH32YkwReFgxx_f08A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA0MCBTYWx0ZWRfXxSXLXxaGIbCg
 1vIwfM/BbPgqrutHM+7qjgPDlcBYAX7udMjKKvCuhHTMxUHWZBnl4VqGAOl7ezhVjTR5WlPXlQl
 IGlw31Lam7g8KSwa3DjN6heiDs6Ug2HM21Ffk2XtgLXS8oypLZFlrN8ZV1pIORlCA7A3flj7yFf
 7lNJ7ygI/p0oeQJFZ2t9L5GIFRTgGwHOwI477g9k8K6lCN8VYWhTQDSKkFodDtoLW9org4HJwnY
 VGCn2sWlhp9RP3TJc76G6zml2VBTyZ7NdIZDUY0Lkz9uS5WkAv0KQAUhj+zdfcFq+42O2KxuYqI
 lK29x8Cm0c0pg8KD8X0wplC7T3zS4p3pxVQBQUxCq6Dl4vTQgEnTtLSCnPhTFBRgTdGEE2l1DGu
 /5KbFh1RwTUTS7PBKvlt5yBUCBkbY9oPCpE+0xiHeC/2E+jhlQBY6tAaSz2P7vE4cfYz0bg+AzO
 74VxfneTnZMCtL0E62w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260040
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

On 22/9/26 13:56, Daniel P. BerrangÃ© wrote:
> If CONFIG_CXL=n is added to the Kconfig, the build fails to link
> the PXB device:
> 
> /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_realize':
> /home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:202:(.text+0x330): undefined reference to `cxl_component_register_block_init'
> /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_dev_reset':
> /home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:309:(.text+0x768): undefined reference to `cxl_component_register_init_common'
> 
> Fixes: 6e4e3ae936 (hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142))
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/pci-bridge/pci_expander_bridge.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 40ffbc4e082..8977243a804 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -123,12 +123,14 @@ static const TypeInfo pxb_pcie_bus_info = {
>       .class_init    = pxb_bus_class_init,
>   };
>   
> +#ifdef CONFIG_CXL
>   static const TypeInfo pxb_cxl_bus_info = {
>       .name          = TYPE_PXB_CXL_BUS,
>       .parent        = TYPE_CXL_BUS,
>       .instance_size = sizeof(PXBBus),
>       .class_init    = pxb_bus_class_init,
>   };
> +#endif /* CONFIG_CXL */
This does not build:

FAILED: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o
../hw/pci-bridge/pci_expander_bridge.c:126:8: error: attempt to use 
poisoned "CONFIG_CXL"
   126 | #ifdef CONFIG_CXL
       |        ^


