Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208E7C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzB9k-0001bJ-WF; Wed, 26 Aug 2026 06:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzB9i-0001ax-Dj
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:46:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzB9g-0000hD-Qf
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:46:54 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QAGp0M107561
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kn4/ry2UJYpmbTyjQ0BbTOAxkKYTu4OpjZIWhPjiCPU=; b=f7VjZwCF0DGyCePV
 5JgdjLVwKk/FrPwrHqYT39p7y/FYEKDiVXzSOQdtq8Bim7HHFfgE2a5cYN4Wh3Sj
 O/kVIBuqKv82cPiBoRBt6gGsF2haRSBQX77iaJfqnbtyQZQDOkszEADcob+usQ+9
 p13naV8998wRIqQ7u0fQLrYy1SEpdUhiZgpf/Ci2dhbSCIeVkc+xurvfEdgBJ0b7
 c9SNXngE4mOLd+EgmoeHlLuUfjrQQ0dAODCSGpr+zgv+YKOlEL1CocTjkIzn+VD9
 dNYERbtRXEDB81NMVAnvYLvnjTsS9J2ukzSw3crpCra4SL3DRwPK09eWSxbj5/NA
 oJsZ6Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9s9g9e6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:46:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52f52ccd459so717021cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 03:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787741211; x=1788346011; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kn4/ry2UJYpmbTyjQ0BbTOAxkKYTu4OpjZIWhPjiCPU=;
 b=gKCGwLtB2tQV+3QvDVYiKXYQIYZMLBXVT5pKR3JkfO5aep8s2qMlUQKlk7ezaOpT4n
 bnOTNpiqi9y6PAPj7iRqGzI8zDBdxllFBThOmrGxv1gGjH9xFEnwIijbDNtgLgN0ggBr
 XvHNQjdrPy4mup1d7KAn7ApE/9BERbAufg6lQki7QRFuPzwnd4/IiMNU0Q0QOGqOOVb1
 PmFJuTt+yfeDWJJaDCLLqd1qAlJ1A1oOM2imxyOTTVRPpYHy/xtdPz+rgbrZH5JzLBLj
 7kGp3RP8fCtfHdMsh6wKpTk7tIAWcXYWUTp+86k/wb2AYJy37qxuRB0O61/4R0zXA3qZ
 ZuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787741211; x=1788346011;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kn4/ry2UJYpmbTyjQ0BbTOAxkKYTu4OpjZIWhPjiCPU=;
 b=F5sDNMDW71K59sYtxe0Oo5MNfWYB96GNJ1WfE+FJDtQBBmpBdUBr8Nvf+1DSGJU3Fe
 IEr6geZeRWRKoxWw2QIQvnpVmm6BNlBl7T+MUz6Y5f/jp960mUZyr1m7U/CPWUtsTMmK
 YcjAr5FD5z+/IFVQrc1CEJQAdaGVg7CK15RESFn6o4V504UPGYb7OpHvg6w9vWUI27bQ
 fBqj7joa/mRNEz4+s9ap1bma9MwuNtsn50O1x5a/JwBSZ7ihiaTpx+qyHYHtYcFWXcb6
 F2w8rcrlHanyvMdN0QRm6Vop46yd8suuol60JUSr24S/WBxqZrFu5sUQyVsAajHJTTbu
 gNEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpoTQn1ROfmAXy+bZuVEIP+gGr4CKGKG1wV/E9R2GmRLNNbWIfGgLaKnymAWwrYRUeIhaPtdqFIZ5zg@nongnu.org
X-Gm-Message-State: AFuF++mvHTS1r5Tu6w5MPCpYbjJzhFTedxeCacfaOdRFDZKZrwtTqth9
 3cvwiBPmIQy7RHo5VkSp6XPM+ALfAOucfg7Dvv2YU+j+DbGVtCNEhmUBk4v4UEGmtXMO5CXKhHA
 ONZ2E+cwdMGVZwFqX0Nuboa0oPEDmxkEYA6oFLN4yF3zCnOcdbMumIcvraGpQMOhvMA==
X-Gm-Gg: AR+sD10GJBAUDqY3uZoexF5Xg2pl+lhHzbP3tCa8PUTJvsdiz52dAGQTA5OKGitsJ9b
 RLVfzuKh27jny/46rbhjevbMJSk7kEaPnAv2P0UsIoxoQmMwKzQPtHy5f5mI0aHbTToNczB8VUC
 Bqu+rupPc/f9TRaHUifHhzJLHwXOUNVMGxyOyCQpL8o1GhhjzKCfUOf2CUrb4+M03QRBd8tShCd
 4iGbXZUOS4dHHdSqvJ6nvmZjbJwIoRPjgSymeqz7SUou3hkikZUese+bQO+GJZKIXlOrTtcP1ek
 lUGQPLGyxrYalR388RSzTuWUufBIbA4WVn1IE80S/NjclLnSUBMuUaESnI+/0+gYLPrAaUFeDt2
 lzTojsz7+F1dUQFXzEw6cUCNpZ9gY7PsteUYAzfRZrNOC9A==
X-Received: by 2002:a05:622a:5c0d:b0:52d:9c42:f326 with SMTP id
 d75a77b69052e-52e4241c342mr60990051cf.42.1787741210943; 
 Wed, 26 Aug 2026 03:46:50 -0700 (PDT)
X-Received: by 2002:a05:622a:5c0d:b0:52d:9c42:f326 with SMTP id
 d75a77b69052e-52e4241c342mr60989711cf.42.1787741210602; 
 Wed, 26 Aug 2026 03:46:50 -0700 (PDT)
Received: from [10.254.188.74] (31.18.205.77.rev.sfr.net. [77.205.18.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5b3958sm10455445e9.0.2026.08.26.03.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 03:46:49 -0700 (PDT)
Message-ID: <551c3828-ac37-4e9c-9d27-7f526bb09e76@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 12:46:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/qtest/virtio-scsi: cover a replacement that
 changes the size
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20260812121500.1034178-1-den@openvz.org>
 <20260812121500.1034178-4-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812121500.1034178-4-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yRX1jbuSGXyYeFrdVOrGo6HT_j_z-Ukl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5MCBTYWx0ZWRfX3gg6hE3pR9nN
 4hJK+s931Dn9xBWlzvalU0pi5JTpDLmONeoOjJfiApelDVfoc6YM+WJ/KlYB/jHYxGg4i7Yls6W
 SHrmDpuhP8Cg+f0aUy4JipEB5ERg+aDD56PsrwkO9DJsjndBYcu1ICoFpciIIdtMYCx62KDM9tu
 S5tzQZ2/RP5hFSkhUeWQMV0YSpr2cxn1jKLeaRzgi8yvwREoO8QGHe2vbIkc52Y+j9cl9Wf+WE/
 Jtx8AqveaWGm9bwRina5xWoQJdd5skzekpe1Dt68qxrvmT3uzBsVrYmbu3UBdz2do2ZNnPUzHGM
 xpmTEz7FRWpwywDxjoMgniVwWIq6kTHYqD4rs9WwWjKgh5mzEaSPVxN4cUGm05Ar5fPQhJkg4fu
 V4Y/MoO1fnFZCXzxhrRWVLyFvFWBv6fVSLrlfLNEmd0gmgjSCkiL5qcLuN1yCAjtS1nHNfd0ViM
 gG6S0K0kWC1H6huq2Vg==
X-Authority-Analysis: v=2.4 cv=Xfq5Co55 c=1 sm=1 tr=0 ts=6a8ec41b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=3lFKFk2zyOZBiYL4tutsoA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6rqHouBjAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5MCBTYWx0ZWRfX68Du7o7+j5YX
 K1zRmBjfoLEYGs6aqctCC6JbDyBc6dB4S4NZS39h+zIQPXTf7GTzW9ptbwovAN9sE3+o4cUI6Ng
 T9D+TH0XdbKz4/i+oe2/2/Yc+JSKvGg=
X-Proofpoint-ORIG-GUID: yRX1jbuSGXyYeFrdVOrGo6HT_j_z-Ukl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260090
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

On 12/8/26 14:14, Denis V. Lunev wrote:
> Realize a scsi-hd on a 1 MiB node, replace it with a 128 MiB one using
> qom-set, and check that the device reports CAPACITY DATA HAS CHANGED and
> then serves a read which only fits in the new node.
> 
> Both halves regress on their own. Without the notification from
> bdrv_replace_child_bs() the first command after the replacement fails with
> ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS OUT OF RANGE instead of the unit
> attention. Without the refresh in scsi_disk_resize_cb() the read after it
> is refused the same way, since nothing here issues READ CAPACITY.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   tests/qtest/virtio-scsi-test.c | 63 ++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

