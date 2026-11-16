Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDB606A884
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lgUKNfXG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MJa5yW38
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSx7t-0005ZV-Kx; Mon, 16 Nov 2026 08:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSx7g-0005VZ-Uy
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:51:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSx7f-0003bP-4f
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:51:52 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC0mXu2212650
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4r9eH2+x0BIybleE6I05WzgCER5KC4etCMc3VHK/UNQ=; b=lgUKNfXGM0f9nm84
 ret5wbDd7ZYurBbkfj1lqXlJSeU4LrxVKzO83EP+XMQam6KuyWkv7IfGa/F8c+yw
 rAwMAigxPu0Jok+/LBVf2E3fRg27bCmhOES5tPY5VvycAleRLr2m9hjwdoskSQ20
 mTobu8ouFS75m2+f1Ha0aOX0hUHqgv/SNWz8urX/uInlxaHPP95K6fdPsDoa72w/
 1jDwcQSs0nFryhn6muVrsVs5Jm37/oSYD8peB/eNgak4MDjUc6Jx73X6gLWJlNe4
 h6aZ14Z820AvHMwna2yKA2kP8XazYCGAPbiH6HPhqQhCBzxxPxL/kivIPpM6jUxe
 +T14EQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j00nfgjvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:51:49 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7d2d5cc693fso394575137.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 05:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794837109; x=1795441909; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4r9eH2+x0BIybleE6I05WzgCER5KC4etCMc3VHK/UNQ=;
 b=MJa5yW38fufUvXHdcTulb3dMArOqRiE7/02qPEJa52Ga2V1DE1LKNnXgMCVdA/Jhss
 0/Uo8ODhdFY/nUJ4Yna09v01BHWbnr50vWXRrKIQSxJMybCupYUzRMb96Lnrb6+gaOgF
 9tXxuLAD9EBwc4ET6Qelg8pXlvNXofeXR+xjDsKrz73cjBBYk4zRicJedeOhxEBuw4XE
 83pwTqD+nVv/C5/kU9W+ThMKjHtQfws3s/BLwx++qhFhVhjufVqsJgXEzsBWryr8Af83
 zhPa4AFAmSbRiFi/qHZxnFW23Wu4HnPs8UMbhVPFS3GR9F1F16eAuTjgnmQDiIDOGx/B
 tChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837109; x=1795441909;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4r9eH2+x0BIybleE6I05WzgCER5KC4etCMc3VHK/UNQ=;
 b=s6miIl3pk9I6ldUoVRzoVoW5GlCTrynoUpOojQ9z3zV+ESnBcYGncC1y4JgTpngeOl
 BqQwcg1LenmdJd0Pw3wfgszZz09mAnQxG2k9PBDdaQPAgUMSHAH5c5SP3HiJmUM79R6Z
 2tQbN5+PW9ijkQcxrCPUSiDfgyY26l9xKak83IeM3hXT0HY32JtCvAbENbAR5TzmsWBU
 Pv7bjdQKjRfCQEVAWLIUgT57mIVXGGoDCqDXtKmFpMarOG3GEFJ99E51rq4e9zpqdLwn
 o2FIJUxGzpPtS1Px60mwX70Ra90MAZhkY2Ys29ksxIk9gEbGtLdxoHCk5BbXtrsrwNXY
 MSKg==
X-Forwarded-Encrypted: i=1;
 AL+hErGfrBrySutt8hX2qAp8aKGnfqLE+WdP7ySVttEPcCrk9tcooBfFO8YnDxIvXpKfm54whjPdcjhbhlmQ@nongnu.org
X-Gm-Message-State: APuU4Z96p/w1F0Zhth1fvFYHmgZhzHaBAffBo7NrAPBBZCo2Bmgz/Q5T
 jHswPivNKxXmO70aZupfzOREezxVHCXAMkrbsWSOnko5jE8yklDDU5nxBNE5lxOZ8CS4cDnd7WZ
 jp90xwod3BfOgNQmfi+eIOJLDsLOxgBhnp2YrvaKR1MxMaThm7qh0zS5WYw==
X-Gm-Gg: AYBFou0YCtqwE/kto0DxQ8PeXBqqu663VRI/AqQoFswEu+kwtxlSOOvzuYCBgdabj3S
 P9uset/NxdoiL35Vke9dkQ9D1HHmfkga+SlK0lXHfxRRDS880AhlCOyoGNdViGLc5u2+Sfvuz2E
 FCYI6qFULQn2qDERsT9j+k/r6UnJjJO0lBIafL0/aGegGoTD3Z+bp+36F4epr5mle9IU0QCa0c2
 wqWZ/3KiszM0JnzlS3YYoaTo0Z9ZlHVm5lVo7pfckeutYC5VYG3R8iCYE9d+OGYBxCky2JPSJwq
 Wlfc+CpgY/Aq90WfPlGHZnsFOCSoI5Vi7FGFo8Ob0/KIfPpZ17kr4GyjBLigK90kI5xjv3d2fZ1
 SUVg30jKSdCovJo3aLGj/9vrwj7t1AnEizv1nSdyDmL4jpnY9OgZs3HuIUNOiNsZiuo/+0t/csi
 P9khSW5t4=
X-Received: by 2002:a05:6102:1625:b0:7c2:635a:4f4b with SMTP id
 ada2fe7eead31-7d64d7ca73dmr2926432137.29.1794837108711; 
 Mon, 16 Nov 2026 05:51:48 -0800 (PST)
X-Received: by 2002:a05:6102:1625:b0:7c2:635a:4f4b with SMTP id
 ada2fe7eead31-7d64d7ca73dmr2926424137.29.1794837108096; 
 Mon, 16 Nov 2026 05:51:48 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5b4a3fcdsm261921765e9.0.2026.11.16.05.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 05:51:47 -0800 (PST)
Message-ID: <d6dd9ec4-d3b6-41c7-a79d-e72161aeaf37@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 14:51:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user.rst: clarify handling of VFIO_USER_VERSION
 capabilities
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, clg@redhat.com, qemu-devel@nongnu.org
References: <20261116114947.3365480-1-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261116114947.3365480-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BrEIUoX5 c=1 sm=1 tr=0 ts=6afb0a75 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=64Cc0HZtAAAA:8 a=ktGqtvewGCSDwWZHQcUA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NSBTYWx0ZWRfX4NbP5N0KxgyQ
 MCwp1Yc4HfpQQK3ZMCeT1Y/0OtevzKS8ExGxpnndGEVXiexSRuiLUc8TwrXXbl4DCMWuUYKGUa0
 XEwF+M6RPqo3+6395eBb0AL/Z1uBp1M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NSBTYWx0ZWRfX2z4UXFAf+3nD
 XzfSkgfNu1Oir22if4CtmCZOZKqAdVZyxiwtaHhPmoOOo0lcDYJhkVGJKvY2N7Bzqa6MdafN5tq
 ymbuWvUyzfFYXYCCdrOHjq8yCS95f6Axpb7xdeOBNwHkWIOBI4E5W2p62rqn+k+9VAfEja1tJrT
 5YGX8EMb6xbvOZ4IVm4YgQ74eQ5ztYwFRD8o9RUmtIeH30Z8fejdrgh7Tz21lKJV3IEBQMQ+Qyl
 9SJdUyXGzjqUzZO+gCJGiGgmxZqccdnW/0/1zfy1jpc+X//a/q02qzkx3xKXD6FKtHzT2zQxd7C
 b1sq0H2VRUe7G6kP5G3D9IdCgiFS1mHPP+Mz/jZPQm9x022lZSi7WJu/1bY/PuKR4SliknFDOwD
 SYWM5RolcojdKP8TKxQAFgsnzKPqbb6pMkU6pmleofnoZqs8k+69qUbJZOD3CrT66n577LnECn5
 uu5cZNFvUXG1R0K9QCQ==
X-Proofpoint-ORIG-GUID: BJt8ke7wy5ddVBz2LgS2Ryeem4upTMed
X-Proofpoint-GUID: BJt8ke7wy5ddVBz2LgS2Ryeem4upTMed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160055
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mark,

On 16/11/26 12:48, Mark Cave-Ayland wrote:
> The vfio-user protocol specification currently lists each individual capability
> as being optional and provides an indication of the default value within the
> description text.
> 
> Clarify that all VFIO_USER_VERSION capabilities are optional (including if no
> capabilities are provided in "version data")

What happens in if "version data" is empty?

> and move the default values to
> their own separate column within the capabilities table to make them more
> visible.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   docs/interop/vfio-user.rst | 61 +++++++++++++++++++-------------------
>   1 file changed, 30 insertions(+), 31 deletions(-)
> 
> diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
> index b49781a755..4a5cfbb704 100644
> --- a/docs/interop/vfio-user.rst
> +++ b/docs/interop/vfio-user.rst
> @@ -515,37 +515,36 @@ format:
>   
>   Capabilities:
>   
> -+--------------------+---------+-----------------------------------------------+
> -| Name               | Type    | Description                                   |
> -+====================+=========+===============================================+
> -| max_msg_fds        | number  | Maximum number of file descriptors that can   |
> -|                    |         | be received by the sender in one message.     |
> -|                    |         | Optional. If not specified then the receiver  |
> -|                    |         | must assume a value of ``1``.                 |
> -+--------------------+---------+-----------------------------------------------+
> -| max_data_xfer_size | number  | Maximum ``count`` for data transfer messages; |
> -|                    |         | see `Read and Write Operations`_. Optional,   |
> -|                    |         | with a default value of 1048576 bytes.        |
> -+--------------------+---------+-----------------------------------------------+
> -| max_dma_maps       | number  | Maximum number DMA map windows that can be    |
> -|                    |         | valid simultaneously.  Optional, with a       |
> -|                    |         | value of 65535 (64k-1).                       |
> -+--------------------+---------+-----------------------------------------------+
> -| pgsizes            | number  | Page sizes supported in DMA map operations    |
> -|                    |         | or'ed together. Optional, with a default      |
> -|                    |         | value of supporting only 4k pages.            |
> -+--------------------+---------+-----------------------------------------------+
> -| twin_socket        | object  | Parameters for twin-socket mode, which        |
> -|                    |         | handles server-to-client commands and their   |
> -|                    |         | replies on a separate socket. Optional.       |
> -+--------------------+---------+-----------------------------------------------+
> -| write_multiple     | boolean | ``VFIO_USER_REGION_WRITE_MULTI`` messages     |
> -|                    |         | are supported if the value is ``true``.       |
> -+--------------------+---------+-----------------------------------------------+
> -| sparse_mmap_fds    | boolean | ``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS``      |
> -|                    |         | capability is supported if the value is       |
> -|                    |         | ``true``.                                     |
> -+--------------------+---------+-----------------------------------------------+
> +All capabilties are optional. If a capability is not included in the request

Typo "capabilities".

> +sent by the client, the server should assume the default values specified in

The "must" -> "should" change should be justified.

> +the table below:
> +
> ++--------------------+---------+--------------------------+-----------------------------------------------+
> +| Name               | Type    | Default (if unspecified) | Description                                   |
> ++====================+=========+==========================+===============================================+
> +| max_msg_fds        | number  | ``1``                    | Maximum number of file descriptors that can   |
> +|                    |         |                          | be received by the sender in one message.     |
> ++--------------------+---------+--------------------------+-----------------------------------------------+
> +| max_data_xfer_size | number  | ``1048576``              | Maximum ``count`` in bytes for data transfer  |
> +|                    |         |                          | messages; see `Read and Write Operations`_.   |
> ++--------------------+---------+--------------------------+-----------------------------------------------+
> +| max_dma_maps       | number  | ``65535`` (64k-1)        | Maximum number DMA map windows that can be    |
> +|                    |         |                          | valid simultaneously.                         |

Pre-exiting, "64 KiB - 1" is more accurate.

Previous was optional, now default is always present. Can we clarify?

> ++--------------------+---------+--------------------------+-----------------------------------------------+
> +| pgsizes            | number  | ``4096`` (4k pages only) | Page sizes supported in DMA map operations    |
> +|                    |         |                          | or'ed together.                               |
> ++--------------------+---------+--------------------------+-----------------------------------------------+
> +| twin_socket        | object  | (empty)                  | Parameters for twin-socket mode, which        |
> +|                    |         |                          | handles server-to-client commands and their   |
> +|                    |         |                          | replies on a separate socket.                 |

"empty" is not clear; maybe "absent" (unless requested)?

> ++--------------------+---------+--------------------------+-----------------------------------------------+
> +| write_multiple     | boolean | ``false``                | ``VFIO_USER_REGION_WRITE_MULTI`` messages     |
> +|                    |         |                          | are supported if the value is ``true``.       |
> ++--------------------+---------+--------------------------+-----------------------------------------------+
> +| sparse_mmap_fds    | boolean | ``false``                | ``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS``      |
> +|                    |         |                          | capability is supported if the value is       |
> +|                    |         |                          | ``true``.                                     |
> ++--------------------+---------+--------------------------+-----------------------------------------------+
>   
>   The ``twin_socket`` capability object holds these name/value pairs:
>   


