Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634C5C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiK2r-00079C-MH; Fri, 10 Jul 2026 18:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiK2p-00076N-P3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:50:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiK2n-0001oa-8g
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:50:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3ii61648591
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tPNHlurI4KnWpnd23Sec3dKht0jP85Wmv5rOqTzVwpw=; b=HmVeM5GP1MsvyrAi
 QaDasczNZTbviSYjsjKCtLp8Kifidz/GqdxbzLU+UDGk3fA40PpoSYIn607AseMn
 VnorfgzXs5oI4cY3rLcTO9dIq9BKQK0w4V1lrITV4wi3mP4XOTkIusFYyaj8py55
 09rz4FVDl9KllQsBG/UjvNQ6j0N5I/tf+b0M3cj5brmTY3EK5cH3eXMSO1b1eqtZ
 f8eL9oo1wnU0p/jwwjqcN7/TtU33pjf/vuVE3naNIr4W1xlor9oVgMsmGX/QYlE5
 zg5mEN/NKnUuUwJp4WS8Csa/UgnwOtFF05pxfV61hCN+Sgz+nVLFS/Ck9iooSVCB
 o91Eng==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txhjau-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:50:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso24726901cf.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783723802; x=1784328602; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tPNHlurI4KnWpnd23Sec3dKht0jP85Wmv5rOqTzVwpw=;
 b=jbTVAqF5/S3zjYVsYJe+sNENuEP0lWEXNpuhV+PEA7mS5bqxw7gqNeSTcz/20Rw/xH
 3pwB5pweut+qGes51wLHVMDrzPAq3aCnp+Z5EqMNXcKN/YZZRt+H/5u9UsbpZpNYn09x
 NWdMxdIBS2LQBxibqIb+KjEv4m3CsLLndu4GbCmMYisc47C+a4HmMB3UKp/cFU4K+RkO
 xpxa+IXDPt7MP5zLkz2cTmL4g2w8A3gITVDgxKVoRnkiGMxkke+C9MgRnxU9MlB3AEm0
 g0BAo9FeaEM/IuEj0XVzJfaeJXxcKN/ETDMYm0zdMYG9eNij1a75RsVtvB5MW6Dlchzx
 g52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783723802; x=1784328602;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tPNHlurI4KnWpnd23Sec3dKht0jP85Wmv5rOqTzVwpw=;
 b=iIeHTv/YDRxKInQaxk4We9EsrUhXIKkufWPVTyvmzotUsxC3aw7194yYzdX7hm49Ux
 9y3zqXrqLPUbaXILnvW7z8qqXTYWBxMzDjOLpfgTqvEpjvJEKxKerET24VXHWKeiM1Ev
 PL4ncTBDSptD/f6aLPg5gPZsLTuxGvCntjuGhLXBRvKLy9MMz7s8kFU+OGHulNime9Mf
 P+xxmesTCggApbl3tCCmYSPEKhwzyYR3oXjo3isfL5IsThDta/nrK6/yPJGV5li7pde3
 tVQWHGkKJ4Pch8cxm0Shxh1fh4qZolJjsbrnipIm4iFcRVWtCVst13+bxasJHKqbumtO
 hiNw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaH0SbP/eNHPUSGed2Z7l5gzmz4HOTEBwCbnFaOBuoXal/+/MAyPvacWAAsRXFD7it8hQjPGCkc36F@nongnu.org
X-Gm-Message-State: AOJu0Yz5hc4dZ/fvfqVHPypJ99idY8Htn42Ve8QILD7rAoPK6gSoVU0R
 eDqiXrF4N/Q+tu3yhCOG/4tkcpxWXE+epj24VA3dVDIC56ooaSxD6SCRRdMB1Ka61I0jsxrnlM3
 5/HdYX2HDbxN7wjMf8Ky8xLTeBvZVir0QMovUUk7QrQHy94d6yYABQ5bk6g==
X-Gm-Gg: AfdE7ck0ybtE60OdOdVuVYJ2O6UO4I9e03ne5lPngPpC1HSROajgKiwG0Igj79exW30
 mgV9zkwrQzcmqG3rKFQ0t80Jy2wCXscUU2T2rytMBXxc86IitnpczMD+XeDR/XAndcn5leUQfn0
 Yfd5BURgRn26EEjkeM8+Hhf3o6sEixdIgE2VFO/2A5LEjWpD3/A6xcSlmeIMdWB2A6FTzQXpyIB
 6fwtDN5wyKBXBWoCszJJhR9MeRhQ+aCMusLnDaC/qIyhNW58Y1AuyTRgo8zMoTkxhUAaQ8WiL/F
 /H2W7TjpyIHOWd9rM7c2SElhsjpfJeupoRfB5Nvr2Gk6UjyuD7PAQJRGpVb6+E9V+hIGNx1rIeC
 RbceQDlNvPmjjukhPY9vt5oCMZ7VfsU9o2DEq4NS2TN+77PsNm2gFhT4SrxyqWw==
X-Received: by 2002:ac8:5f13:0:b0:519:75f9:e874 with SMTP id
 d75a77b69052e-51cbf0e0734mr9859201cf.10.1783723802207; 
 Fri, 10 Jul 2026 15:50:02 -0700 (PDT)
X-Received: by 2002:ac8:5f13:0:b0:519:75f9:e874 with SMTP id
 d75a77b69052e-51cbf0e0734mr9858971cf.10.1783723801802; 
 Fri, 10 Jul 2026 15:50:01 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f273195d9sm6933092f8f.3.2026.07.10.15.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:50:00 -0700 (PDT)
Message-ID: <088b0485-c813-4d34-8836-ddb9f887b840@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/hexagon: raise SIGBUS on unaligned data access
 in sysemu
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, matheus.bernardino@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Alessandro Di Federico <ale@rev.ng>
References: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
 <20260709233436.3075100-4-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260709233436.3075100-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a51771a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Jr9J1cUnv8ykJZtwNJIA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 82m492Bv82wNeIVJD1Nn1rx6JQqrllrd
X-Proofpoint-GUID: 82m492Bv82wNeIVJD1Nn1rx6JQqrllrd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyOSBTYWx0ZWRfX9qJBNH5uEabB
 TlK4SEWUKORvk08DDPZP07m1i/Z25J/O1/vJ7OUmE2FIGqYcazq9vaVaWGGaMPPvfhHX6UbsKD0
 7YGM0RurJNQn5CswtW0Ymd2kzWYmvfg3dPN4ywl34n0vhtkj1C2XooVTUYkUUMy75vW/C/3Rvca
 /AUmo3zb/tEfx5ideRPm3RU6B2qbS8INHHlYfSmfpNVE2iVCL75hFr2BLNKhXwwgyA+LcR4XaP0
 lHN876A9rODAN8+joBeb9IDZQbqIeRTrVhrJ2fHkMJz4byf+5arxxgyPowTH4elMlvcPituSG1j
 tfU1bBamPlx0ut3u0y1rBThxxdmyH/Rp2O+k86J9dKS4zL4ALbBPq70SRM7pntz9nHIlb1+zlX/
 lQNGIvhCUgmdmoLRjazV5/ULHur3GjA3z91n3C6UkJTU/F8Um4SidLaxjUS2LcPX7H2P2jD9rUX
 HXe0xZxjCIhf9P5KTwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyOSBTYWx0ZWRfX8QQOiVEDF5NW
 N5ZxI37+sp3x8VussDUuUEXaM6L7ARO4ZgliclL2w4g7/2LmHvpnz0Y/8w9PtLWr2k9xvkt5QUt
 PXz+tGVrGcXaCK1bY0aoVcwYwk+ZuBI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100229
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

On 10/7/26 01:34, Brian Cain wrote:
> hexagon-softmmu had no enforcement of alignment for scalar loads and
> stores: the MO_ALIGN flag added by the previous two commits triggers
> TLB_INVALID_MASK/alignment faults in cputlb.c, but Hexagon's
> TCGCPUOps did not implement do_unaligned_access, so the fault was
> never delivered to the guest.
> 
> Add hexagon_cpu_do_unaligned_access(), which raises
> HEX_CAUSE_MISALIGNED_LOAD/_STORE via the existing HEX_EVENT_PRECISE
> path, mirroring raise_tlbmiss_exception()/raise_perm_exception().
> 
> Also add a linux-user cpu_loop handler for these two cause codes for
> consistency with hexswi.c's sysemu handling, even though linux-user's
> own alignment check in accel/tcg/user-exec.c currently raises SIGBUS
> before Hexagon's cause-code machinery is reached.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   linux-user/hexagon/cpu_loop.c |  5 +++++
>   target/hexagon/cpu.c          | 25 +++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
> index 0958c51fbb3..d7f73439dbc 100644
> --- a/linux-user/hexagon/cpu_loop.c
> +++ b/linux-user/hexagon/cpu_loop.c
> @@ -76,6 +76,11 @@ void cpu_loop(CPUHexagonState *env)
>               force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
>                       env->gpr[HEX_REG_PC]);
>               break;
> +            case HEX_CAUSE_MISALIGNED_LOAD:
> +            case HEX_CAUSE_MISALIGNED_STORE:
> +            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
> +                    env->gpr[HEX_REG_PC]);
> +            break;
>               default:
>                   EXCP_DUMP(env, "\nqemu: unhandled CPU precise exception "
>                       "cause code 0x%x - aborting\n",

It would be clearer to have this hunk in a preliminary patch
(more even since the $subject is about sysemu).

