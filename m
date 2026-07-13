Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB01C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjAxN-0002J7-MF; Mon, 13 Jul 2026 03:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjAxM-0002Ir-5b
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:20:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjAxH-0008S0-Ct
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:19:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6Nu15568057
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 07:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6ERFB8oxOn2Uo4ck1nsBITHX8wsLlxjU1fYVMhozEz8=; b=cuBJkwp+gYPngkq4
 tHjUtvmXnHznkPLE2HGD397SO4jfryvbm6hsruSziIRs0Q4SA5lY5saMyVLEayzW
 n3i3dg/ApOn868ftOEIajPGLVQzY3dl6ygRz/UW4yOsY593j6JOMv2GvtaEQrjWB
 b9cetJPoZG7x4EzfRRuCMBXeecYkpfWuW3FG7UN1LMjj+SJaXpCpcLtTnKZkzhpn
 e9yVKquldRTK2imljLSuKd/W3RHvdLO2xxwtVFEk6svXItJoGsTHRqe4YQzeWTYj
 rNtqSzyb+IFBJ+Cq6N+cOtj9xgJO67sbAvl+F4x6+cXjlUOYlbWz3d+p5KS6wCk6
 i5BTRQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe914x79-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 07:19:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so46923991cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 00:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783927192; x=1784531992; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6ERFB8oxOn2Uo4ck1nsBITHX8wsLlxjU1fYVMhozEz8=;
 b=i40paQWoCLs0DokX3sTNumak0eBgQWIvg/BBaDHDcnLyu9UUXE4iWjaKQcRhHzVJ+9
 0hj/UVV/6yR8oDZ25ntHFqQOFqIDncjCPphlBBgiSf7gZsamuwYys2bfz6YHAgz1IFo5
 tcxiwZ5AxJ4rMbaKP/dUGiTtDkAS+2YYXvM5N0FqaXh2ilM8qo0MJyS9WTxCj9jjGHMC
 NQV284oXrZoKZH1bCh6YKQbGCmtLHlD+30yMzTumsq+RmoTpcA/LD9CdKshadcBOY6OE
 9Ei1J426YOzScPUSAkAKuwFxH0s3U4RfdefxS8cetu/fgq2KS7Z2G0pe7rH+3FeoS5SL
 lyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783927192; x=1784531992;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ERFB8oxOn2Uo4ck1nsBITHX8wsLlxjU1fYVMhozEz8=;
 b=dhXx1T3PflOy02vh0rXWnsBbNjG9i6v+OvqaTJCTtv+xxee6eKfhqEam/jVtIpoZfr
 aUpwVysRF9WfkM7Y29VMAOrBR4wmlIfkCQ2IUbuurCfrwBcm3gGnBh2WHml/uGqbG4Qe
 dWGgQ8Nkwe/TabL3XkNfItnPK3lu5Cc5IrDWQMf7svcr7RcELz/C+FkxbbqFBUXJb+OX
 1t/A1tnyG1/Az6R/ZAsneOflNfJfat+CKtNIAdiVIlwrV1gRKFWoyoRXxrCFfK6O1b8m
 EqCLubapqq2RnbGTbU5ut2LmT3B1Ikkn8nQdFcYhpiUC5MlKJfdYgExOE75BY0Uu2yfd
 cghw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxxnwzbJHb3OBB8W5Z2UbZ+p68WQ79AdScImQbG49DGFSbfhKRD7ojJxrIkzC6zQGTmiN3gE2hWijq@nongnu.org
X-Gm-Message-State: AOJu0Yx1MRgK10173W5xhAESUqxVr9YYg38UyaKJuzypy+kLAJ8WLME3
 UnQPNIBow3UwXT5WHeGxScTB5hnGeiU8iFADSPZZR6VBpzdWBM0sKpy05WAwWtDi/Uv3tncWvpy
 A4VvRChem4WyrAc5bnZjj8FgHhcVbjt5zsjNiXbLDb+Uccp01uIfhT63Pqw==
X-Gm-Gg: AfdE7ckAGZQ3vbfPG6FXRVotALo48lDLAHkEN0fR9MwJWuXjLsc3UFaGbiZKa6sTNn5
 DL6DfP1Sfd4n3JzPZ7paIynxpH/bjNMkMbNSHM5qpwWKLFVVNC7BD9YU2no7rsS6BGpt2Jw85QR
 Wa/vd314FmFTnoZUO+0MjdJn/dhy+mIhc+R6QhSKljVked65n9gAeqmWoiU5aYhdrxGPAimK71G
 pUg4+OGRCoztccwBQaCK4Zb4sY2jfujqf3Aq8CptxA/z6YaeXlpyCAoKbdV6Y35+ehw6GDyCkJ2
 KPFYFD5D/AM1HkdVEpmjp62kOKnZuv5gLVxXczlkbzR+D6R5aqaCn+UZJ6Px7Qu6Q6jeCQYygdj
 M2dX2nfRwYjtUsifYtpYtcVevdWu41KNP8W8EjHBm61ZFdXlDPWNKHgyIX0lIgA==
X-Received: by 2002:ac8:5f51:0:b0:51c:1cf8:ca4d with SMTP id
 d75a77b69052e-51cbf171caemr83469401cf.13.1783927191914; 
 Mon, 13 Jul 2026 00:19:51 -0700 (PDT)
X-Received: by 2002:ac8:5f51:0:b0:51c:1cf8:ca4d with SMTP id
 d75a77b69052e-51cbf171caemr83469221cf.13.1783927191483; 
 Mon, 13 Jul 2026 00:19:51 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f373csm570076305e9.14.2026.07.13.00.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 00:19:50 -0700 (PDT)
Message-ID: <fcbe651b-d7b3-4080-8f86-f3ffd40a0087@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 09:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/10] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit with migration compatibility
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "peterx@redhat.com" <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
 <20260713032704.3583103-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260713032704.3583103-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a549198 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=V2NxCb60AAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=GfncpqaTsXqTwz3xVyUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NCBTYWx0ZWRfXx8KhVXniMhDF
 MIfGqGo4YZOWGlbPchPDlgdlKsqvGRhwvw1ygoOJ9zn3dcPNH46/ZRnER5zvjHQCmXUEUJjhyMX
 jh+SDKEoFl5daCZwf20d8aLf/2d3EpA=
X-Proofpoint-GUID: NaoLUSBjDE5dS0_WJ7mUr_or6aY1nwRf
X-Proofpoint-ORIG-GUID: NaoLUSBjDE5dS0_WJ7mUr_or6aY1nwRf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NCBTYWx0ZWRfX2B4Wx5r0caOX
 feW36IvF1ekPO/oqUZ/CfqtI778qrwTcy89zqamkIEelKziP3BnHvaavh2jzbf07ioPMbp+IsYE
 zL6yDKUIGCw1gQtxOLwT8HtTcAGxQdDuxPmy+QzpcMff4BdNUL37Z2/JrUR2TbatRv8gnpivuDQ
 ZM/kaQGDqsZTplbDjGs5asjiY9lfxWJNcHG4XLenBoUcGRcSHYATKncC4tOS1bi47rWATS7SoXV
 CElvGwz3kCWV98068dkwTWFgk5bLWCaglV6MffLLN+JD3ucgqDs9RKwoBkbktYcSfdzYKLQOxPC
 nEOFKY5YdK6vXmuzu5TzpG5tB2It6IMFzs15Ju3jsLCG8r9eENTvtntXT0rMRI5RTkgC58KKbdf
 3cz90WkKXUPUsXmR8EXzQ5L8bZSJRkuIJIYRYQSwRO6zVlfyiISKSDZuwlRydzG9xUejfcRg8F6
 l4Qi+B9oq/WTGNI8X9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130074
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

On 13/7/26 05:27, Jamin Lin wrote:
> Change internal EHCI descriptor addresses from uint32_t to uint64_t.
> 
> The following fields are updated:
> - EHCIPacket::qtdaddr
> - EHCIQueue::{qhaddr, qtdaddr}
> - EHCIState::{a_fetch_addr, p_fetch_addr}
> 
> Update get_dwords() and put_dwords() to take 64-bit addresses and
> propagate the type change through the descriptor traversal paths.
> 
> Adjust NLPTR_GET() to operate on 64-bit values:
> 
>      #define NLPTR_GET(x) ((x) & ~0x1fULL)
> 
> so that link pointer masking works correctly when descriptor
> addresses exceed 32-bit space. The previous mask (0xffffffe0)
> implicitly truncated addresses to 32 bits.
> 
> This patch does not change the on-wire descriptor layout yet.
> It only removes the internal 32-bit address limit and prepares
> for later patches that will add full 64-bit QH/qTD/iTD/siTD support.
> 
> Update the EHCI trace-events prototypes for QH, qTD, iTD, and siTD to
> use uint64_t for the address argument and print it with PRIx64. This
> ensures full 64-bit addresses are shown in trace output and improves
> debugging of queue heads and transfer descriptors.
> 
> Migration compatibility:
> 
> To preserve backward migration compatibility, keep the legacy 32-bit
> fetch address fields (a_fetch_addr_32, p_fetch_addr_32) alongside the
> new 64-bit fields.
> 
> Migration format is selected using a machine compat property
> "x-migrate-fetch-addr-64bit":
> 
> - Old machine types migrate 32-bit fetch addresses
> - New machine types migrate full 64-bit fetch addresses
> 
> This is implemented using VMSTATE_UINT32_TEST() and
> VMSTATE_UINT64_TEST() so that only the appropriate format is migrated.
> 
> In pre_save, the 32-bit shadow fields are populated when migrating
> to old machine types. In post_load, the 32-bit values are restored
> into the 64-bit fields when loading old migration streams.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/usb/hcd-ehci.h   | 30 +++++++++++++-----
>   hw/core/machine.c   |  2 ++
>   hw/usb/hcd-ehci.c   | 74 +++++++++++++++++++++++++++++++--------------
>   hw/usb/trace-events | 24 +++++++--------
>   4 files changed, 89 insertions(+), 41 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

