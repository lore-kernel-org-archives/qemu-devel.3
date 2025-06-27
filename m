Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21318C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 14:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV9i3-0007EZ-FK; Fri, 27 Jun 2025 10:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV9i1-0007DR-UR
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 10:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV9i0-0006SX-4Q
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 10:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751033138;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qiUHlUwRTtOeycYenbTYku29+WxK2EOQMBu5/2LMQhM=;
 b=PlCJIlTxYC0Dxj98TIQHwSJgWee3Ypg32PZBtMvEHj2U5zlupZTzqSuMNOnS2fq6nm+dh9
 RJCNHK4UM1Jh6QbBGBC3W7g+IqG9V7wQTor/oGy3ndEC728S0QzfHd7jEYV7NF4Uxo2gNr
 Op+nRNkAZu3w5Ev3DotEhjTNUz6Hxr0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-g27t7nZ2N62lmVAYTWxwRw-1; Fri, 27 Jun 2025 10:05:37 -0400
X-MC-Unique: g27t7nZ2N62lmVAYTWxwRw-1
X-Mimecast-MFC-AGG-ID: g27t7nZ2N62lmVAYTWxwRw_1751033136
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f3796779so1070040f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 07:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751033136; x=1751637936;
 h=content-transfer-encoding:in-reply-to:references:reply-to:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qiUHlUwRTtOeycYenbTYku29+WxK2EOQMBu5/2LMQhM=;
 b=X2BViETS5YwOV46YXLZLw+wRLLeFi6JMGdhxYN6F4QQXpUI0t5PbjfWiiYtxtC8YLs
 +D58qDim02xQ1DFeDoopoHy+oSXYw+7KfmQWM23JP9ihz+zJcT7EIiZovjotbpSWgRsk
 x1ds08Pi6wf099yIIKkx0eWpYVSxZfhzhueVQwBXhueWto9hfcdUceaa4/kg6QCoVhu3
 SXB+6JXVSg2ipTIHcy9mOH6tZq6eSYpVJ3CpsfZ0/XJijHJDQ7FXLUABBjxI/At43Pnf
 y0cmEHACnArogTCc/DcflNpAUFVBw6T61LXRp2kPGRJKKcTncEPlG+C6f17T7iL/0Df/
 78iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5jclVDqWyCuCvczukosCMWzn6K69lLP8zMUa1bXj1rmOzVCEY9bLTULJrZtggb8j2pBBUBxDBXFQV@nongnu.org
X-Gm-Message-State: AOJu0YzEV/TzQbpz2Rk5ulUvAsyKWw3ewG14oZRKeI+EJPo4EKzQG9VA
 /4fdOiVa5pCx8K2BBmtmZe4mb8/4AHO5aaSY0Af3tg/APg8NylTAKiYndKCTL8PAzvbaoOce3z0
 TfGNF7ZqEyi+LRLfHMtqN/5boUewrc9shhNQpnJNXQW1xvCh66JTSpeYj
X-Gm-Gg: ASbGncvkrhgoTwSQYS/kjDGf0f5vV0gWeW3/aSF8VsA9GIw0zFtKEK9eUBU8suE1KlO
 JR04sJdwYvr1YaHFo0Tgvs3QePdF5fTxFaPFYPrMtfnLjatyx6v0QJv4hYJgjkrlMoCTQZZ246w
 FbK71nmNMLR5Eyi1JEYgz6jDCdZM0ki3m7Nj7VUJReniJt2EhnYmSVUHBaOBu3kTV3iuXlhFsJi
 kVZRwVX8fhDlC7mq8TeSFdgcQ4C9hRI9m1FHu2tMsNYHXvAsE+85zFZZOppAnMzNxeW0l26S/kO
 MBkrrjwMa9OgrSU/+n7rTXfD4ub6hNjNxm466EJp39CTbqYNQ1EcoH13X9NPneA+z4dATw==
X-Received: by 2002:a05:6000:490a:b0:3a5:2949:6c38 with SMTP id
 ffacd0b85a97d-3a91846d660mr3331163f8f.52.1751033135341; 
 Fri, 27 Jun 2025 07:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAKSxUEGAfPbfmfUZfpXzTSws5Zvn5M5kcxepW3JJKM6A2qOsniE0K+HmGptNqIUZ/su4YKg==
X-Received: by 2002:a05:6000:490a:b0:3a5:2949:6c38 with SMTP id
 ffacd0b85a97d-3a91846d660mr3331077f8f.52.1751033134556; 
 Fri, 27 Jun 2025 07:05:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453814a6275sm56990555e9.1.2025.06.27.07.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 07:05:33 -0700 (PDT)
Message-ID: <c98c9d01-ccd9-4e3a-a24e-9a42cf1b4b8e@redhat.com>
Date: Fri, 27 Jun 2025 16:05:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] hw/arm/virt-acpi-build: Improve comment in
 build_iort
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
 <20250623135749.691137-5-gustavo.romero@linaro.org>
 <adf5e6e5-e0e3-44f9-949c-620aea3edfa0@redhat.com>
In-Reply-To: <adf5e6e5-e0e3-44f9-949c-620aea3edfa0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  eric.auger@redhat.com
X-ACL-Warn: ,  Eric Auger <eric.auger@redhat.com>
From:  Eric Auger via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/27/25 3:57 PM, Eric Auger wrote:
> Hi Gustavo,
> 
> On 6/23/25 3:57 PM, Gustavo Romero wrote:
>> When building the Root Complex table, the comment about the code that
> s/table/node? or do you refer to the IORT table?
Reading the IORT spec again, both terminologies are used, ie. node / table

So please ignore my comment

Thanks

Eric
>> maps the RC node to SMMU node is misleading because it reads
>> "RC -> SMMUv3 -> ITS", but the code is only mapping the RCs IDs to the
>> SMMUv3 node. The step of mapping from the SMMUv3 IDs to the ITS Group
>> node is actually defined in another table (in the SMMUv3 node). So
>> change the comment to read "RC -> SMMUv3" instead.
>>
>> Signed-off-by Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>  hw/arm/virt-acpi-build.c | 25 +++++++++++++++++++------
>>  1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 9eee284c80..e9cd3fb351 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -370,7 +370,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>          /* DeviceID mapping index (ignored since interrupts are GSIV based) */
>>          build_append_int_noprefix(table_data, 0, 4);
>>  
>> -        /* output IORT node is the ITS group node (the first node) */
>> +        /* Output IORT node is the ITS Group node (the first node) */
>>          build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>>      }
>>  
>> @@ -407,23 +407,36 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>      if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>>          AcpiIortIdMapping *range;
>>  
>> -        /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
>> +        /*
>> +         * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
>> +         *
>> +         * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS) is
>> +         * defined in the SMMUv3 table, where all SMMUv3 IDs are mapped to the
> s/table/node
>> +         * ITS Group node.
>> +         */
>>          for (i = 0; i < smmu_idmaps->len; i++) {
>>              range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>> -            /* output IORT node is the smmuv3 node */
>> +            /* Output IORT node is the SMMUv3 node. */
>>              build_iort_id_mapping(table_data, range->input_base,
>>                                    range->id_count, smmu_offset);
>>          }
>>  
>> -        /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
>> +        /*
>> +         * Map bypassed (don't go throught the SMMU) RIDs (input) to ITS Group
>> +         * node directly: RC -> ITS.
>> +         */
>>          for (i = 0; i < its_idmaps->len; i++) {
>>              range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
>> -            /* output IORT node is the ITS group node (the first node) */
>> +            /* Output IORT node is the ITS Group node (the first node). */
>>              build_iort_id_mapping(table_data, range->input_base,
>>                                    range->id_count, IORT_NODE_OFFSET);
>>          }
>>      } else {
>> -        /* output IORT node is the ITS group node (the first node) */
>> +        /*
>> +         * Map all RIDs (input) to ITS Group node directly, since there is no
>> +         * SMMU: RC -> ITS.
>> +         * Output IORT node is the ITS Group node (the first node).
>> +         */
>>          build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>>      }
>>  
> Besides:
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Eric


