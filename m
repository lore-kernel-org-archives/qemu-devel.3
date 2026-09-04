Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFE1C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2RUY-0002jq-Iz; Fri, 04 Sep 2026 06:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2RUW-0002iT-7K
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:49:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2RUU-0005mx-Ll
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:49:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AIkYV2679356
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 10:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I3Z5ffJmWgePWxgnAIFbt94EjpW7qVI5iVPqSRXnUVs=; b=JroAIMFvBVJP1Fnx
 Y8uwO0c+H+qnkAuFETzDtfkP12jA7S1UNigzob/cn6SDgyFclNYMAI+BNj1OMPkf
 MhqErOySMULGL+PSnkZAbGcn8ckp5Pe812p4tQt8OyzOcDO3cbIOWGM3SXdh3NeM
 nQNlgJT4C8cOvniAcaVUeUy8YBu4KV0y0OOsP03FZ/MdF/6bx3bagCI6h12EMFk6
 NnDSD21DiP8DNhbSL9Q4WuTlGtkTx3YbmLM8rCPNUAC2YEkXScm61tzZufG5ZwY1
 +c2nDk6aEgIgRAwu0SjzwtZOy+FAVzH7JN7cKMXcmy936sTtj++yq3d7yi7W0P5q
 UdN3ww==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp1fhavs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 10:49:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939665a1ae6so219426185a.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788518989; x=1789123789; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I3Z5ffJmWgePWxgnAIFbt94EjpW7qVI5iVPqSRXnUVs=;
 b=HKIkrfawGGQevN8yDnRvu/qCTTAuhKIzb8eLFrH/35tX8z0VOgzoQrCy2pfC/83GqV
 JA1fnSEQfH9xAz1W4ziiwLKRi1GEGAdP7fDR8S+MQRR0dIYcqqfjORVP3mHABee4JuIp
 RBsZLjMNG6eaqmUc1yW3bYrSDgQKUzLACvKD764gAgrBKWD0OwTUAx3vcAcBEnaKAgKW
 gcM9Z4dEZR9Ah7K+G1iUcOiOfTbac3zXSisJzduKacjRUNUD8svC7eBTk5c7nYM0V9Kg
 MC9GuxpEGbAGP3wLtkS28Bu8Mh+rfpoaLnk7nw/ZKJdTsgo6kYT+2k1ylY8Z7EXxReUZ
 AJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788518989; x=1789123789;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I3Z5ffJmWgePWxgnAIFbt94EjpW7qVI5iVPqSRXnUVs=;
 b=jTRgnm1rGR/MHtkPra3MOMP8iFL4TR7XKcEHFofrNLLNefSD1AjitD1+ETCRvaEm8w
 KZgm22Rf2y+EDCKL7B970xJ/7jAGd22N8w5XOFuiVgd7p49UAGiBBQ0+Grhm60WT+iHl
 u3U0di7kfWrw7s7DkoW5itwqEbRPGqH/CW0EMrTJgjx6NWWcMAX9NfiUI/PXOeN+FrIr
 E3W1pAa2TnPOAzZYtLPqRVoeIsxf3yTFoXVgGtbaInMHTcFM3rJlaHBlO2XTiUd6RDWz
 ALFupPIKY7JMgZwDstDoKdPTMr0FFkNTyxP/ViNkMP7bYTNnzK/xKqhV0eWYI5jxfg31
 NMCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwr6GE+GG01DqlW4jhUdtJaUV0UBr0ps8NppNnBYhASa12yfdWEhAYFArlLsPczuc/W/31hlVWdLdyG@nongnu.org
X-Gm-Message-State: AFuF++lexQDFEorthRwHgdWrGNMidZTz/3xFjC/5Sy/kID//VgKlfuPI
 LRfGHn5Y4zxdQGtGzsKNPKA/Cftepxd7we3gG51fM80S2wdw3xFS7Yn+YNvCov7bmyojdxfbdmW
 nWb7antOnrXNJj49a8wwTXfMAtrkCC0jH9VH5wQgGS1hKGHgoUc2jLMeRaQ==
X-Gm-Gg: AYBFou2DRV5VbuXJ4kRoUyZaj1pcAt4vi8TLxrsbX48o+0aiII4xJKYuyu5MhtbVFhG
 TvGJ5nZ7+QMyM2EWktrZuXw2mfbiXHG/gONOWV7Ic5PvxPVn1wFeJjOxJw/RnzKZiO18aHZmosQ
 dnb1TRXa7BnIK6Fkn1qahkkxGmdwjHw6rEzZ8lFYbjrPaoQH5Bmr0Ucp95WizPRoZWHcYYYladE
 6ee3E0MTCSg6oGFRhLfx/mHErBKJ+mObdrXy3NooXiPb0CKNCMxGcOEPQtTfxxWPpULjJuCkwzE
 LzChUvui5zMDmYPZ5CaPqTFh5J9EtLEnU0UZpH5QWL/HkmshHgL1KSfG5m6IYRal8umP9UKhB8M
 gNPzvUjjTxsybgvmJj0likif1YMj5gyVH0g==
X-Received: by 2002:a05:620a:ac14:b0:937:27fb:96f8 with SMTP id
 af79cd13be357-9398048b0e8mr448273585a.41.1788518989086; 
 Fri, 04 Sep 2026 03:49:49 -0700 (PDT)
X-Received: by 2002:a05:620a:ac14:b0:937:27fb:96f8 with SMTP id
 af79cd13be357-9398048b0e8mr448264785a.41.1788518988052; 
 Fri, 04 Sep 2026 03:49:48 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6023edsm144861465e9.7.2026.09.04.03.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 03:49:47 -0700 (PDT)
Message-ID: <63b6c4c9-9ecf-4761-88d9-fbf76f761cf4@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 12:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/16] hw/riscv: Socify Atlantis
Content-Language: en-US
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
Cc: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org" <mpe@kernel.org>,
 "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "clg@kaod.org" <clg@kaod.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
References: <20260903055131.257903-1-joel@jms.id.au>
 <5ae005b5968e375e341c7bcbc076c78f2d2bd426.camel@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <5ae005b5968e375e341c7bcbc076c78f2d2bd426.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F+xnsKhN c=1 sm=1 tr=0 ts=6a9aa24d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8C0MhvPsAUCMf7Mh04IA:9 a=QEXdDO2ut3YA:10
 a=VxAk22fqlfwA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: sj88KrxcHLZpXARPG40PpcnpD8y5g71b
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA5NyBTYWx0ZWRfX/2bs+15GAT5J
 v7VW8XkUtZGHXDC2cXuvo0cVP0AzBIPZBFXymZw2P49BPflzjPcGtwMFHTFjW3Zg8+GUUL2kb5w
 T4QeSc4HxDEtxt6NqwjG5j8qtlKge88=
X-Proofpoint-GUID: sj88KrxcHLZpXARPG40PpcnpD8y5g71b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA5NyBTYWx0ZWRfX/Dni0f+eA+KC
 nlvG08UcBquspBwr4yOFpYKrlvc7v8MYyUJt3rL6A7BAMIhGemNhi0BHJ7+HJjHb21IJxaJ+jY0
 a6VEUNfcT8XTLMPwVBjgTdU7Y73KNH1fgsO+5xfQIFfKPIgHFtjwy3hnyHVjxUnJSs76xuviO1Q
 SJJu/sWGu/pLX2874wKysGrzmNo/X98t+s67LJ5mKfzpUJkGlpsumVYsu958fft25vzeRKpGuP0
 t5UXWUI/ZQOg11ZY09l+QfnPmcoN4sQsH5qteu8cylNCOEXuXW2c7FrOQVswtyYdhpvk9SXVMHK
 pHgJHVfWT2yhg7EMm4Qzvw5PFlCn7GzKnjCQ/q5bRwh5lF3yGSfbjfzQnYiCJgRWnK4s8cjEupV
 ZwK/F0U9H3eQoxTfBXPK3kN6JRYfKtbEsJS+bNUH2/E5VBNsyq6hsPtzMqEeAmAm3U2sa4HBAqM
 AFGdL217zA01VpoWhxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040097
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

On 4/9/26 01:35, Alistair Francis wrote:

> Applied to riscv-to-apply.next

Great! I made a comment on patch #14 which can be addressed later:
https://lore.kernel.org/qemu-devel/a4b3c4a2-e359-4952-8b1a-34db4e2b3c9a@oss.qualcomm.com/

