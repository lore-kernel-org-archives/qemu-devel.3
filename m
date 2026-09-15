Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE04C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 22:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6bhS-0004pd-Kz; Tue, 15 Sep 2026 18:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6bhQ-0004pB-Eq; Tue, 15 Sep 2026 18:32:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6bhN-0004FR-FG; Tue, 15 Sep 2026 18:32:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FLVrfl791682; Tue, 15 Sep 2026 22:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/OPa+w
 lcWBvbN/NbEZzqY77uWSSSVuv3/NlAf54sAro=; b=AMz3NUQBj5qmoD5KlbRAiD
 lUXGQeWlPtY5KV2fmOP77pIX47vGIf3xOvgUk/rvknPZtLiFpkgCyzDjbX3nhn+z
 sduxWO2heX/RH7VTPzaUjZGXj1ZPtqlLbJkECGGwvNmDqlOxVqrU3aFnU0xBhtgC
 vgWa4XFvqxRp1/8NfPKslkqy1iHjwg9P4Sea4sdGafmSeDV79q6mTRZrFRxTatza
 2/eY2+mAvF7g0Cjn4H+1eixJFZtQQWOR1YuJ0hzbNQKNNDBneQcf2xfzIXlERx1l
 M9qj7ALyr5ZHWp3F6/zL+v9cOaQwhPVvgT1P52zZkIXZbLEFH6LD05UzsjH+iMMw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e1h9a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 22:32:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FLZxGx426507; Tue, 15 Sep 2026 22:32:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089km0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 22:32:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68FMWGij32834210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2026 22:32:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A633D58067;
 Tue, 15 Sep 2026 22:32:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0A8A58052;
 Tue, 15 Sep 2026 22:32:15 +0000 (GMT)
Received: from [9.61.250.152] (unknown [9.61.250.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Sep 2026 22:32:15 +0000 (GMT)
Message-ID: <ab31af69-0f30-47e9-befd-8297d6849e22@linux.ibm.com>
Date: Tue, 15 Sep 2026 15:32:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] linux-headers: Update Linux header to 7.3-rc3
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, clg@redhat.com, armbru@redhat.com
References: <20260914174420.12309-1-alifm@linux.ibm.com>
 <20260914174420.12309-2-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260914174420.12309-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMyOSBTYWx0ZWRfX3FLV1f2nOwsJ
 dpFZznxTF5YR+AQOH25IxMya/BfvpmcAuRF18LsFkwmtZEiDmwrWTwvEOrBGoE881lxpglQHgbP
 6WHTwb+uoikZ8He/pbFP/h4O3D3BYDmJxRetnBe/oc+NTnRND1YVSGxkG1bhOFzfNAasz97QeMH
 CfrrKvI7XcmOO9mlsuglvgK8VahPszqzgCYbIweE5gUObVLVK3ZMq83mMqV8ojU05Wyzql+8DUP
 Mh+yz1IUrbYvl5Jno9rc28998j97S7as4OSe3M59jzGLV8eI4yBV7IFN3FSh5pT9TgtWsuey15R
 21UOjPbyUVWZeUFePmB1cQ+xUMTe+AqMWxxRgbfiraYiAoeauVzJkgpmtw4kmgXGtjO6RpVZ++Z
 pPTYBiA9R35K3ND3kE8zPyi1okRWSwe6hmE+jV//4+ueMBn21ECxz9/nnaMl+ebARkiwDanKVpr
 +E+nbVxACdCznV/7yoA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa9c772 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=wEM8WcOVVUVNRjnXpjQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: L4a1lLCW3jMZs0gBPQmYwYGir3MKyqf0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMyOSBTYWx0ZWRfX/t+czQ4Q99KY
 7TnkQ4x2SvEbfickqVbXG+wUoXxd6eVOF9nhQGvUwj6wMjp+EGQZ1gUneSEy8I6sV3MWvTUXi93
 8OPOwq+XuFGGoBDJuQMzWwAFrS03YcA=
X-Proofpoint-GUID: L4a1lLCW3jMZs0gBPQmYwYGir3MKyqf0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150329
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

It looks like I didn't correctly update the headers in this version and 
so it didn't pick the VFIO header changes correctly. Will wait for some 
feedback before spinning a new version.

Thanks

Farhan

On 9/14/2026 10:44 AM, Farhan Ali wrote:
> Update the headers to include VFIO and zPCI VFIO changes.
>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   include/standard-headers/drm/drm_fourcc.h | 209 ++++++++++++++++++++--
>   include/standard-headers/linux/fuse.h     |  63 ++++++-
>   linux-headers/asm-arm64/kvm.h             |   1 +
>   linux-headers/asm-riscv/kvm.h             |  13 ++
>   linux-headers/linux/kvm.h                 |   1 +
>   5 files changed, 267 insertions(+), 20 deletions(-)
>
> diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
> index 2ba0b5c925..ca4f4e3d8c 100644
> --- a/include/standard-headers/drm/drm_fourcc.h
> +++ b/include/standard-headers/drm/drm_fourcc.h
> @@ -1645,36 +1645,69 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
>    * For multi-plane formats the above surfaces get merged into one plane for
>    * each format plane, based on the required alignment only.
>    *
> - * Bits  Parameter                Notes
> - * ----- ------------------------ ---------------------------------------------
> + * Bits    Parameter                Notes
> + * ------- ------------------------ ---------------------------------------------
> + *
> + * DRM format modifier fields on AMD GPUs:
> + *     7:0 TILE_VERSION             Values are AMD_FMT_MOD_TILE_VER_*
> + *    12:8 TILE                     Values are AMD_FMT_MOD_TILE_<version>_*
> + *      13 DCC                      Delta Color Compression, supported on GFX8 and newer
> + *   55:14 (chip specific)          See below for details, depends on GFX block version
> + *   63:56 Vendor                   Value is DRM_FORMAT_MOD_VENDOR_AMD
> + *
> + * Chip specific fields on Gfx9 and newer:
> + *      14 DCC_RETILE
> + *      15 DCC_PIPE_ALIGN
> + *      16 DCC_INDEPENDENT_64B
> + *      17 DCC_INDEPENDENT_128B
> + *   19:18 DCC_MAX_COMPRESSED_BLOCK Values are AMD_FMT_MOD_DCC_BLOCK_*
> + *      20 DCC_CONSTANT_ENCODE
> + *   23:21 PIPE_XOR_BITS            Only for some chips
> + *   26:24 BANK_XOR_BITS            Only for some chips
> + *   29:27 PACKERS                  Only for some chips
> + *   32:30 RB                       Only for some chips
> + *   35:33 PIPE                     Only for some chips
> + *   55:36 -                        Reserved for future use, must be zero
> + *
> + * Chip specific fields on Gfx6-8:
> + *   16:14 MICROTILE                Micro tile format
> + *   21:17 PIPE_CONFIG              Number of pipes and how pipes are interleaved
> + *   24:22 TILE_SPLIT               Tile split size
> + *   26:25 BANK_WIDTH               Number of tiles in the X direction in the same bank
> + *   28:27 BANK_HEIGHT              Number of tiles in the Y direction in the same bank
> + *   30:29 MACRO_TILE_ASPECT        Macro tile aspect ratio
> + *   32:31 NUM_BANKS                Number of banks
> + *   55:33 -                        Reserved for future use, must be zero
>    *
> - *   7:0 TILE_VERSION             Values are AMD_FMT_MOD_TILE_VER_*
> - *  12:8 TILE                     Values are AMD_FMT_MOD_TILE_<version>_*
> - *    13 DCC
> - *    14 DCC_RETILE
> - *    15 DCC_PIPE_ALIGN
> - *    16 DCC_INDEPENDENT_64B
> - *    17 DCC_INDEPENDENT_128B
> - * 19:18 DCC_MAX_COMPRESSED_BLOCK Values are AMD_FMT_MOD_DCC_BLOCK_*
> - *    20 DCC_CONSTANT_ENCODE
> - * 23:21 PIPE_XOR_BITS            Only for some chips
> - * 26:24 BANK_XOR_BITS            Only for some chips
> - * 29:27 PACKERS                  Only for some chips
> - * 32:30 RB                       Only for some chips
> - * 35:33 PIPE                     Only for some chips
> - * 55:36 -                        Reserved for future use, must be zero
>    */
>   #define AMD_FMT_MOD fourcc_mod_code(AMD, 0)
>   
>   #define IS_AMD_FMT_MOD(val) (((val) >> 56) == DRM_FORMAT_MOD_VENDOR_AMD)
>   
> -/* Reserve 0 for GFX8 and older */
> +#define AMD_FMT_MOD_TILE_VER_GFX6 0
>   #define AMD_FMT_MOD_TILE_VER_GFX9 1
>   #define AMD_FMT_MOD_TILE_VER_GFX10 2
>   #define AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS 3
>   #define AMD_FMT_MOD_TILE_VER_GFX11 4
>   #define AMD_FMT_MOD_TILE_VER_GFX12 5
>   
> +/*
> + * Gfx6-8 tiling modes.
> + * A complete reference implementation is found in addrlib in the Mesa code base.
> + *
> + * - Microtiled modes (1D):
> + *   Pixel data is organized into micro tiles of 8x8 pixels.
> + *
> + * - Macrotiled modes (2D):
> + *   Micro tiles are further organized into macro tiles.
> + *   These are optimized for even load distribution among memory channels.
> + *
> + * Note that only THIN1 modes are exposed here.
> + * THICK and XTHICK are for 3D images and not relevant to DRM format modifiers.
> + */
> +#define AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 0x2
> +#define AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1 0x4
> +
>   /*
>    * 64K_S is the same for GFX9/GFX10/GFX10_RBPLUS and hence has GFX9 as canonical
>    * version.
> @@ -1773,6 +1806,146 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
>   #define AMD_FMT_MOD_PIPE_SHIFT 33
>   #define AMD_FMT_MOD_PIPE_MASK 0x7
>   
> +/*
> + * MICRO_TILE_MODE, 3 bits. Determines the micro tile format.
> + * Only relevant to Gfx6-8.
> + *
> + * DISPLAY - Displayable tiling
> + * THIN - Non-displayable tiling, a.k.a thin micro tiling
> + * DEPTH, THICK - not exposed, not relevant to DRM format modifier use cases
> + * ROTATED - not exposed, not implemented in Linux or Mesa
> + */
> +#define AMD_FMT_MOD_MICROTILE_SHIFT 14ULL
> +#define AMD_FMT_MOD_MICROTILE_MASK 0x7
> +
> +#define AMD_FMT_MOD_MICROTILE_DISPLAY 0x0
> +#define AMD_FMT_MOD_MICROTILE_THIN 0x1
> +
> +/*
> + * PIPE_CONFIG, 5 bits. Number of pipes and how pipes are interleaved on the surface,
> + * which means the shader engine tile size and packer tile size.
> + * Typically matches the number of memory channels, or number of RBs.
> + * Only relevant to Gfx6-8 macro tiled modes.
> + *
> + * P<n>_<a>x<b>_<c>x<d>
> + * where:
> + * <n> - number of pipes
> + * <a>x<b> - shader engine tile size
> + * <c>x<d> - packer tile size
> + */
> +#define AMD_FMT_MOD_PIPE_CONFIG_SHIFT 17ULL
> +#define AMD_FMT_MOD_PIPE_CONFIG_MASK 0x1f
> +
> +#define AMD_FMT_MOD_PIPE_CONFIG_P2 0x0
> +#define AMD_FMT_MOD_PIPE_CONFIG_P4_8x16 0x4
> +#define AMD_FMT_MOD_PIPE_CONFIG_P4_16x16 0x5
> +#define AMD_FMT_MOD_PIPE_CONFIG_P4_16x32 0x6
> +#define AMD_FMT_MOD_PIPE_CONFIG_P4_32x32 0x7
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x16_8x16 0x8
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_8x16 0x9
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_8x16 0xa
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_16x16 0xb
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x16 0xc
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x32 0xd
> +#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x64_32x32 0xe
> +#define AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_8x16 0x10
> +#define AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_16x16 0x11
> +
> +/*
> + * TILE_SPLIT, 3 bits.
> + * Only relevant to Gfx6-8 macro tiled modes.
> + *
> + * On GFX6 (or with depth tiling modes on GFX7 and newer),
> + * the GFX block uses the GB_TILE_MODE.TILE_SPLIT field directly.
> + *
> + * On GFX7 and newer with non-depth tiling modes, the GFX block uses a
> + * split factor which is stored in the GB_TILE_MODE.SAMPLE_SPLIT field.
> + * SAMPLE_SPLIT may be: 0 - 1 byte; 1 - 2 bytes; 2 - 4 bytes; 3 - 8 bytes.
> + * The actual tile size and tile split bytes are calculated as follows:
> + *
> + *    bpp = ... <- bits per pixel in the current image
> + *    thickness = ... <- depends on array mode; may be: 1, 4, 8
> + *    num_samples = ... <- number of samples in the current image
> + *    tile_size_pixels = 8 * 8
> + *    tile_bytes_1x = thickness * tile_size_pixels * bpp / 8
> + *    sample_split_factor = 1 << SAMPLE_SPLIT
> + *    tile_split_bytes = clamp(tile_bytes_1x * sample_split_factor, 256, dram_row_size_bytes)
> + *    tile_bytes = clamp(tile_bytes_1x * num_samples, 64, tile_split_bytes)
> + *
> + * In both cases, the display block (DCE) has no SAMPLE_SPLIT
> + * and just needs the tile split bytes in the GRPH_CONTROL.GRPH_TILE_SPLIT field.
> + * To maximize compatibility between GFX6-7, we don't include the SAMPLE_SPLIT
> + * in the format modifiers.
> + *
> + * The actual tile split in bytes is: 64 << field value
> + * Possible values of this field:
> + *
> + * 0 - Tile split is 64 bytes
> + * 1 - Tile split is 128 bytes
> + * 2 - Tile split is 256 bytes
> + * 3 - Tile split is 512 bytes
> + * 4 - Tile split is 1 KiB
> + * 5 - Tile split is 2 KiB
> + * 6 - Tile split is 4 KiB
> + */
> +#define AMD_FMT_MOD_TILE_SPLIT_SHIFT 22ULL
> +#define AMD_FMT_MOD_TILE_SPLIT_MASK 0x7
> +
> +/*
> + * BANK_WIDTH, 2 bits. Number of tiles in the X direction in the same bank.
> + * Only relevant to Gfx6-8 macro tiled modes.
> + * The actual bank width is: 1 << field value
> + * Possible values:
> + *
> + * 0 - bank width is 1
> + * 1 - bank width is 2
> + * 2 - bank width is 4
> + * 3 - bank width is 8
> + */
> +#define AMD_FMT_MOD_BANK_WIDTH_SHIFT 25ULL
> +#define AMD_FMT_MOD_BANK_WIDTH_MASK 0x3
> +
> +/*
> + * BANK_HEIGHT, 2 bits. Number of tiles in the Y direction in the same bank.
> + * Only relevant to Gfx6-8 macro tiled modes.
> + * The actual bank height is: 1 << field value
> + * Possible values:
> + *
> + * 0 - bank height is 1
> + * 1 - bank height is 2
> + * 2 - bank height is 4
> + * 3 - bank height is 8
> + */
> +#define AMD_FMT_MOD_BANK_HEIGHT_SHIFT 27ULL
> +#define AMD_FMT_MOD_BANK_HEIGHT_MASK 0x3
> +
> +/*
> + * MACRO_TILE_ASPECT, 2 bits. Macro tile aspect ratio.
> + * Only relevant to Gfx6-8 macro tiled modes.
> + * Possible values:
> + *
> + * 0 - aspect ratio is 1:1
> + * 1 - aspect ratio is 4:1
> + * 2 - aspect ratio is 16:1
> + * 3 - aspect ratio is 64:1
> + */
> +#define AMD_FMT_MOD_MACRO_TILE_ASPECT_SHIFT 29ULL
> +#define AMD_FMT_MOD_MACRO_TILE_ASPECT_MASK 0x3
> +
> +/*
> + * NUM_BANKS, 2 bits. Number of banks.
> + * Only relevant to Gfx6-8 macro tiled modes.
> + * The actual number of banks is: 2 << field value
> + * Possible values:
> + *
> + * 0 - number of banks is 2
> + * 1 - number of banks is 4
> + * 2 - number of banks is 8
> + * 3 - number of banks is 16
> + */
> +#define AMD_FMT_MOD_NUM_BANKS_SHIFT 31ULL
> +#define AMD_FMT_MOD_NUM_BANKS_MASK 0x3
> +
>   #define AMD_FMT_MOD_SET(field, value) \
>   	((uint64_t)(value) << AMD_FMT_MOD_##field##_SHIFT)
>   #define AMD_FMT_MOD_GET(field, value) \
> diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
> index abf3a78858..cee8342d4e 100644
> --- a/include/standard-headers/linux/fuse.h
> +++ b/include/standard-headers/linux/fuse.h
> @@ -240,6 +240,14 @@
>    *  - add FUSE_COPY_FILE_RANGE_64
>    *  - add struct fuse_copy_file_range_out
>    *  - add FUSE_NOTIFY_PRUNE
> + *
> + *  7.46
> + *  - add FUSE_IO_URING_CMD_ADD_QUEUE
> + *  - add FUSE_HAS_IO_URING_BUFPOOL
> + *  - add fuse_uring_cmd_req bufpool struct
> + *  - add bufpool offset field to fuse_uring_ent_in_out struct
> + *  - add FUSE_URING_ZERO_COPY, FUSE_URING_ENT_ZERO_COPY, and
> + *    FOPEN_IO_URING_ZERO_COPY flag
>    */
>   
>   #ifndef _LINUX_FUSE_H
> @@ -271,7 +279,7 @@
>   #define FUSE_KERNEL_VERSION 7
>   
>   /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 45
> +#define FUSE_KERNEL_MINOR_VERSION 46
>   
>   /** The node ID of the root inode */
>   #define FUSE_ROOT_ID 1
> @@ -379,6 +387,12 @@ struct fuse_file_lock {
>    * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
>    * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
>    * FOPEN_PASSTHROUGH: passthrough read/write io for this open file
> + * FOPEN_IO_URING_ZERO_COPY: use io-uring zero-copy for reads/writes on this
> + *                           open file. Honored only when the serving io-uring
> + *                           queue was set up for zero-copy
> + *                           (FUSE_URING_ZERO_COPY) and the request carries page
> + *                           payload. Otherwise reads/writes fall back to
> + *                           copying.
>    */
>   #define FOPEN_DIRECT_IO		(1 << 0)
>   #define FOPEN_KEEP_CACHE	(1 << 1)
> @@ -388,6 +402,7 @@ struct fuse_file_lock {
>   #define FOPEN_NOFLUSH		(1 << 5)
>   #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
>   #define FOPEN_PASSTHROUGH	(1 << 7)
> +#define FOPEN_IO_URING_ZERO_COPY (1 << 8)
>   
>   /**
>    * INIT request/reply flags
> @@ -444,6 +459,7 @@ struct fuse_file_lock {
>    * FUSE_OVER_IO_URING: Indicate that client supports io-uring
>    * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
>    *			 init_out.request_timeout contains the timeout (in secs)
> + * FUSE_HAS_IO_URING_BUFPOOL: kernel supports io-uring buffer pools
>    */
>   #define FUSE_ASYNC_READ		(1 << 0)
>   #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -491,6 +507,7 @@ struct fuse_file_lock {
>   #define FUSE_ALLOW_IDMAP	(1ULL << 40)
>   #define FUSE_OVER_IO_URING	(1ULL << 41)
>   #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
> +#define FUSE_HAS_IO_URING_BUFPOOL (1ULL << 43)
>   
>   /**
>    * CUSE INIT request/reply flags
> @@ -1247,6 +1264,13 @@ struct fuse_supp_groups {
>   #define FUSE_URING_IN_OUT_HEADER_SZ 128
>   #define FUSE_URING_OP_IN_OUT_SZ 128
>   
> +/**
> + * fuse_uring_ent_in_out flags
> + *
> + * FUSE_URING_ENT_ZERO_COPY: Set if the ent's payload is zero-copied
> + */
> +#define FUSE_URING_ENT_ZERO_COPY	(1 << 0)
> +
>   /* Used as part of the fuse_uring_req_header */
>   struct fuse_uring_ent_in_out {
>   	uint64_t flags;
> @@ -1259,7 +1283,9 @@ struct fuse_uring_ent_in_out {
>   
>   	/* size of user payload buffer */
>   	uint32_t payload_sz;
> -	uint32_t padding;
> +
> +	/* Offset into the bufpool, if bufpools are used */
> +	uint32_t offset;
>   
>   	uint64_t reserved;
>   };
> @@ -1288,8 +1314,22 @@ enum fuse_uring_cmd {
>   
>   	/* commit fuse request result and fetch next request */
>   	FUSE_IO_URING_CMD_COMMIT_AND_FETCH = 2,
> +
> +	/* add a queue */
> +	FUSE_IO_URING_CMD_ADD_QUEUE = 3,
> +
> +	/* add a bufpool to a queue */
> +	FUSE_IO_URING_CMD_ADD_BUFPOOL = 4,
>   };
>   
> +/*
> + * fuse_uring_cmd_req flags for FUSE_IO_URING_CMD_ADD_QUEUE
> + *
> + * FUSE_URING_ZERO_COPY is only supported for queues with bufpools on privileged
> + * servers
> + */
> +#define FUSE_URING_ZERO_COPY		(1 << 0)
> +
>   /**
>    * In the 80B command area of the SQE.
>    */
> @@ -1302,6 +1342,25 @@ struct fuse_uring_cmd_req {
>   	/* queue the command is for (queue index) */
>   	uint16_t qid;
>   	uint8_t padding[6];
> +
> +	union {
> +		struct {
> +			/* base address of bufpool */
> +			uint64_t uaddr;
> +			uint32_t len;
> +			uint32_t reserved;
> +		} bufpool;
> +
> +		/*
> +		 * Index of this entry's slot in the server's io_uring
> +		 * registered buffer table, where the kernel registers the
> +		 * request's pages for zero-copy. Set for
> +		 * FUSE_IO_URING_CMD_REGISTER cmds only, and only on queues
> +		 * created with FUSE_URING_ZERO_COPY. On a non-zero-copy queue
> +		 * this must be 0
> +		 */
> +		uint16_t ent_zero_copy_buf_index;
> +	};
>   };
>   
>   #endif /* _LINUX_FUSE_H */
> diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
> index 6aefe79738..780cc7f729 100644
> --- a/linux-headers/asm-arm64/kvm.h
> +++ b/linux-headers/asm-arm64/kvm.h
> @@ -106,6 +106,7 @@ struct kvm_regs {
>   #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
>   #define KVM_ARM_VCPU_HAS_EL2		7 /* Support nested virtualization */
>   #define KVM_ARM_VCPU_HAS_EL2_E2H0	8 /* Limit NV support to E2H RES0 */
> +#define KVM_ARM_VCPU_PMU_V3_STRICT	9 /* No default PMU creation */
>   
>   struct kvm_vcpu_init {
>   	__u32 target;
> diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
> index 504e733053..20d9959ca4 100644
> --- a/linux-headers/asm-riscv/kvm.h
> +++ b/linux-headers/asm-riscv/kvm.h
> @@ -102,6 +102,11 @@ struct kvm_riscv_smstateen_csr {
>   	unsigned long sstateen0;
>   };
>   
> +/* Zicfiss CSR for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
> +struct kvm_riscv_zicfiss_csr {
> +	unsigned long ssp;
> +};
> +
>   /* TIMER registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
>   struct kvm_riscv_timer {
>   	__u64 frequency;
> @@ -199,6 +204,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>   	KVM_RISCV_ISA_EXT_ZCLSD,
>   	KVM_RISCV_ISA_EXT_ZILSD,
>   	KVM_RISCV_ISA_EXT_ZALASR,
> +	KVM_RISCV_ISA_EXT_ZICFILP,
> +	KVM_RISCV_ISA_EXT_ZICFISS,
>   	KVM_RISCV_ISA_EXT_MAX,
>   };
>   
> @@ -240,6 +247,9 @@ struct kvm_riscv_sbi_fwft_feature {
>   struct kvm_riscv_sbi_fwft {
>   	struct kvm_riscv_sbi_fwft_feature misaligned_deleg;
>   	struct kvm_riscv_sbi_fwft_feature pointer_masking;
> +	struct kvm_riscv_sbi_fwft_feature pte_ad_hw_updating;
> +	struct kvm_riscv_sbi_fwft_feature landing_pad;
> +	struct kvm_riscv_sbi_fwft_feature shadow_stack;
>   };
>   
>   /* If you need to interpret the index values, here is the key: */
> @@ -263,12 +273,15 @@ struct kvm_riscv_sbi_fwft {
>   #define KVM_REG_RISCV_CSR_GENERAL	(0x0 << KVM_REG_RISCV_SUBTYPE_SHIFT)
>   #define KVM_REG_RISCV_CSR_AIA		(0x1 << KVM_REG_RISCV_SUBTYPE_SHIFT)
>   #define KVM_REG_RISCV_CSR_SMSTATEEN	(0x2 << KVM_REG_RISCV_SUBTYPE_SHIFT)
> +#define KVM_REG_RISCV_CSR_ZICFISS	(0x3 << KVM_REG_RISCV_SUBTYPE_SHIFT)
>   #define KVM_REG_RISCV_CSR_REG(name)	\
>   		(offsetof(struct kvm_riscv_csr, name) / sizeof(unsigned long))
>   #define KVM_REG_RISCV_CSR_AIA_REG(name)	\
>   	(offsetof(struct kvm_riscv_aia_csr, name) / sizeof(unsigned long))
>   #define KVM_REG_RISCV_CSR_SMSTATEEN_REG(name)  \
>   	(offsetof(struct kvm_riscv_smstateen_csr, name) / sizeof(unsigned long))
> +#define KVM_REG_RISCV_CSR_ZICFISS_REG(name)  \
> +	(offsetof(struct kvm_riscv_zicfiss_csr, name) / sizeof(unsigned long))
>   
>   /* Timer registers are mapped as type 4 */
>   #define KVM_REG_RISCV_TIMER		(0x04 << KVM_REG_RISCV_TYPE_SHIFT)
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index aea4ab5c69..f21c47bf8d 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -987,6 +987,7 @@ struct kvm_enable_cap {
>   #define KVM_CAP_S390_VSIE_ESAMODE 248
>   #define KVM_CAP_S390_HPAGE_2G 249
>   #define KVM_CAP_PPC_COMPAT_CAPS 250
> +#define KVM_CAP_ARM_PMU_V3_STRICT 251
>   
>   struct kvm_irq_routing_irqchip {
>   	__u32 irqchip;

