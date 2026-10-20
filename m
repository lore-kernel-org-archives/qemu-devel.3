Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC9606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MaGsS5c7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QoTLSlqI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIyIY-0003WZ-Bw; Mon, 19 Oct 2026 21:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xIyIM-0003Vb-Nx
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 21:05:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xIyIK-0007Pk-Hc
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 21:05:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0t7tR3806851
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 01:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3D1D1GLXZSKE+y+P/ov8lUFrEMUIB5IdaIT86yjVn/Y=; b=MaGsS5c73TgnYKEx
 K/zESxpgvGq9XzPFjR2ThdELYIoeJcpqyURzzsFmBe808co5rE+LdYZeJoo+njf+
 TUlSjC7lIA12HFmjfztSIamfVz3A1gW9JhO0JKWek+3XF5fuPyTZVHo4Hb0jlbHx
 5NVW5e6zuALX0IrNQUp3BjwrIxd0D0LhMZt+NfgXqp84By9C/5UevQfCXpxFosEG
 be5mpC8//hpxkxgQfff3xsoUqkmGuyx+XEEFVe96cp9Hc4OrQGRbeF1PC0uYRLxq
 CO1zM3mX6Bw6Hlhuf78ELanbijDY6BphgVBUejStOErMUReSbhpBMSkUpyyLHyc+
 FhTIAQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p87dv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 01:05:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cbf2fd504so469050985a.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 18:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792458332; x=1793063132; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3D1D1GLXZSKE+y+P/ov8lUFrEMUIB5IdaIT86yjVn/Y=;
 b=QoTLSlqI1JboXCTdJjMZ7tQKhsyEWRwBrGL9RLiQuTcgRVu6P0zruKRjhHlExOHGIG
 qceQLbs6Z69YnC14TK6ftkLC2KqIzy6qM2tHvFPVTdNepg1SbdhRQPOHATvbUIMlk2SZ
 cjRZX0YrhzPpsy45QAr4eiTrK4AskhE24lNZaLc5WSrHZ3d1iRnrFRPENyRT6FaKqVNF
 Dl8vnrUwykSC/azr9knI2C4Oqj6xmLzWAQ5f4vetpMBsZBBEv5+UiBw6JZFd3j1hIF/K
 4IKESHZRZpk6JWD0qE+46LvzLPs5jMihUEA0fLl9aUgWx3b8/HZCqutHthe8rLKsmD6V
 2LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792458332; x=1793063132;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3D1D1GLXZSKE+y+P/ov8lUFrEMUIB5IdaIT86yjVn/Y=;
 b=pRJqfhKcFZnnyooyWHu7b/0LWHt1pxK58MQrNiFSJ+vFGgUxp2TGBlwP0Z0OgU47fJ
 eTyXS1F0BuZzniZ24N3wCnzbAmdyl8QGqIdxOzx1uxulpJTpq6kbEbRKl4Vc3WjghXv1
 5EX9OOjNlyFpLYVBSRTiCgUtXhRMb48pGvCNfE0AkiSuCjH4HUH9Zg8Q8znI7AsZKNzs
 Ok74E2g9wq2aAK8jBU+poHa/PVYQPXm56Ku+pKMTwgyQfNlXMt1UBd2uTYKCGxoYxFDh
 XlpQqw1VAhqPCibT/u7Swa/3B8RBfVLec5kFfsvAobrmSwJlkDxALxovonk3gqVvYzJf
 sSWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXN484Bj798je8z0N1YyGJVlULN3fRzWUfkRz9GOUfmd9tf92Yw+IxZLqV3gBWbgban4dwpnoYMsUS@nongnu.org
X-Gm-Message-State: AFq9FYJuCmZ7XC9fwjFS/9hzyJi2wPTr/o6YupMmOP4WcSBNoz8RnzWO
 K2YLmEUmmAEU/WS2LpEqBGjTTHYWJ5lThNkL8n16bN2ASEnmkqv1m2ch4K6MDZQmC1CLT4iOwvP
 u7gWoBxYytny6wiC7SijM1l6UHMP3EHZf9C3+EIYJencdXLQZghNO17mTlg==
X-Gm-Gg: AYBFou0LGf0mrxTcHNscYOTihwp9i8g9ZirG4IFdN+9hw0hi0NJGm+NoifjGSe1dRUk
 iHZXfQg9G+Fcp6YzlmWQy970Belze5aD8aFWnwmee97TlAV5og41dMsLsMtXW7Kx3lJRxDj2+sW
 cDGhzDkDNEikD68t6AxiCbWWdMAbyczgv3OP2UiH+spyLWANly0UqVRNl+l7bG/Vg7Sg7dE6n56
 yTAvP4fjkcs7ncEVmWSQnMtpqW2ttdkS9B+u9Q8BmQauKq8ECVWjNSi4Mv85RVecY8n6fn56fVV
 L9LqOnmHCLMUMdT/MtMIltmIFYxu6e6dwePTjgQvpq8c/ghBIoUc/M5qHWqzWgXxFnmxeg1yerZ
 6UYC+aSyQo6Os+RVdPCrhag==
X-Received: by 2002:a05:620a:2609:b0:93e:f5bd:7e13 with SMTP id
 af79cd13be357-93f29d8e1f4mr1602156985a.64.1792458332640; 
 Mon, 19 Oct 2026 18:05:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2609:b0:93e:f5bd:7e13 with SMTP id
 af79cd13be357-93f29d8e1f4mr1602152685a.64.1792458332051; 
 Mon, 19 Oct 2026 18:05:32 -0700 (PDT)
Received: from [10.251.42.127] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d818c59sm2538259f8f.30.2026.10.19.18.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 18:05:31 -0700 (PDT)
Message-ID: <de908487-9d6b-48bf-b2ae-3b645d0bec36@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 03:05:28 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 16/32] hw/pci-host/aspeed: Add AST2600 PCIe config space
 and host bridge
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
References: <20250929165230.797471-1-clg@redhat.com>
 <20250929165230.797471-17-clg@redhat.com>
 <CAFEAcA8OKABUH8S_F4HrWLKDC9XYqWGxD5_xMAPOPmc614u4UA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8OKABUH8S_F4HrWLKDC9XYqWGxD5_xMAPOPmc614u4UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WSODaHaJZ5yuYtqNluVI1W4VqzZtcBDE
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad6be5d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=V2NxCb60AAAA:8 a=pGLkceISAAAA:8 a=pMHeIudtPmcNLvVDoDMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAwNCBTYWx0ZWRfX8lp1cujEOv2t
 NCr9tpjAhRl1NtfFS98CO6IpQfpyzkYJpIG5v/8usW1QHGt5c4PqvyCt9I0SRVbDqdk4tnBuEAs
 lq8sHTNJvNkfUmsl60+ctJlzx0aj42FRuPQYdhMA3eHrz/Lth9cuSKArg/ecUrVk7rngcfcUQ5I
 ET+S5cJlOPNfQM2jGRfjr6NvZg1DRvO9iw25TN+F9cOPud2WfnUCfmxmQ1Fplgo9Ly66ca+P/Or
 MuMqq00qmsqfu0uRcwPwtfUC+deYCgMsTielNx7sOZOox7D4YIIPki2z7fPOYfdSEAWWmGAJAEz
 61XPzZEfupOyyiGgKbCUlJN+12qz+Ja5doQwnwGt0XTTyPx+UBgYmcrcmQObZmbOiAXboYOqowR
 4d9DPj7XtAhx7KbVTY6ovIk49wwtv54xzYy0/iEOSLAaEP7l6GuT8qCfN7HcK8A+e1vg9xGGeG6
 cCaY9gaUH/uJKJe8fng==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAwNCBTYWx0ZWRfXx0zD0eftq4O4
 rbadqWc+2AKQR6l32OeHRN69bbYJJbRUQesz5TGSYWdoAVBPp6+gIKAAhnIC8PFwbu9zgAz/MKu
 y5gB21lNpxgyEW0hMdL/EgasjSJikvk=
X-Proofpoint-ORIG-GUID: WSODaHaJZ5yuYtqNluVI1W4VqzZtcBDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200004
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 2026-10-17 17:44, Peter Maydell wrote:
> On Mon, 29 Sept 2025 at 17:54, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> From: Jamin Lin <jamin_lin@aspeedtech.com>
>>
>> Introduce PCIe config and host bridge model for the AST2600 platform.
> 
>> +static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
>> +{
>> +    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->desc = "ASPEED PCIe RC";
>> +    dc->realize = aspeed_pcie_rc_realize;
>> +    dc->fw_name = "pci";
>> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>> +
>> +    hc->root_bus_path = aspeed_pcie_rc_root_bus_path;
>> +    device_class_set_props(dc, aspeed_pcie_rc_props);
>> +
>> +    msi_nonbroken = true;
> 
> This sets the msi_nonbroken global in the class init, which
> is run for every type compiled into QEMU at startup. That means
> it's effectively forcing it to 'true' for every machine type,
> whether it's aspeed or not.

TYPE_S390_PCI_HOST_BRIDGE seems to do that since 2015 in commit
8cba80c3a0 ("s390: Add PCI bus support"); why isn't it an issue there?

   1652:static void s390_pcihost_class_init(ObjectClass *klass, ...)
   1653-{
   1654-    DeviceClass *dc = DEVICE_CLASS(klass);
   1655-    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
   1656-
   1657-    device_class_set_legacy_reset(dc, s390_pcihost_reset);
   1658-    dc->realize = s390_pcihost_realize;
   1659-    dc->unrealize = s390_pcihost_unrealize;
   1660-    hc->pre_plug = s390_pcihost_pre_plug;
   1661-    hc->plug = s390_pcihost_plug;
   1662-    hc->unplug_request = s390_pcihost_unplug_request;
   1663-    hc->unplug = s390_pcihost_unplug;
   1664-    msi_nonbroken = true;

            ^^^^^^^^^^^^^^^^^^^^

   1665-    device_class_set_props(dc, phb_props);
   1666-}

   1668=static const TypeInfo s390_pcihost_info = {
   1669-    .name          = TYPE_S390_PCI_HOST_BRIDGE,
   1670-    .parent        = TYPE_PCI_HOST_BRIDGE,
   1671-    .instance_size = sizeof(S390pciState),
   1672:    .class_init    = s390_pcihost_class_init,
   1673-    .interfaces = (const InterfaceInfo[]) {
   1674-        { TYPE_HOTPLUG_HANDLER },
   1675-        { }
   1676-    }
   1677-};

> You're supposed to set this in your 'realize' method, so
> it only takes effect if your interrupt controller/PCI controller/etc
> is actually being used.
> 
> Reported-by: Marcelo Manzo <marcelomanzo@gmail.com>
> 
> thanks
> -- PMM


