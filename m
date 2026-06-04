Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F2FCD6E6D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVADO-0002CX-MT; Thu, 04 Jun 2026 11:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVAD1-00028n-7h
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:42:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVACt-00010L-Nv
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:42:12 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654EKxMK1132273
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 15:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nSFqugc2F6N8zifcZkRgjBjpnBuCUNKoDdInHEvKzEk=; b=kfc4X59gp80ekHw/
 l+El8YbQD9u5KvEZhrC8W/OSQB1rC99PTrqTQ4bMIB+slkGgMwCCD5KufzHk53wH
 rMjYnExXtO2prWot2CHRbeTBYgPfBgR5tYDl+Jw7d4dSGcdRmokpJLVy/nM8ou0x
 f7tCESb+tBldLc6ewS/DdsX0RdvvwsQ0bu1PUTeHP+sDOv3I32LEZEokTHZTbUU+
 B3/njSkeucGY7gZmeRIUdPgcmJq39wV7ol0lyLm3Djba6AkcjO2f1e8VTgKJ0gV/
 ox+tU5iVD+hLRcIEpZZUPEFvzlQ8HHuqA6+lMqfVQE49fkO2lSsjGgD8LluPk+D0
 nwaSJg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wshrhv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 15:42:05 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137f304f564so1563242c88.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780587725; x=1781192525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nSFqugc2F6N8zifcZkRgjBjpnBuCUNKoDdInHEvKzEk=;
 b=eUDx/AYFUjBocn5tIk7sZr7ImsBkPJcEzTMzhi9ZFQ/2WM/Y5A4Qn7TEF3leVIt0O/
 Qu5qBndnRZfCtASyed3zFz9nRxab19+j42YlAvJLiaR4lMD4MAkx3EYtrFOhqqe3HgUj
 QcABxaJCz0YAlvuzEHK+DbMuv4Ckus/N/8PFS+JTETSpG6p/RTOvGUonfEMxNRa5Oax8
 38ZpEYb2Jd5mKrrz64/p8soeKi6BGESvGtUdPcBLYorKUxaKQOoPRkBpkzNgIAv5W78f
 QZuVEtiK1i/4/i6YglUgj/+nmKbcFsIJnF0Ktw1ZfE3lVFrY78fDLziBerth0aT7dfA9
 Iwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587725; x=1781192525;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nSFqugc2F6N8zifcZkRgjBjpnBuCUNKoDdInHEvKzEk=;
 b=nvj9rIbqHSJ2Lt2GDsh7dF7CTU5gQckGa9bKmO1z60+ADgC+7zJzfamcMC4WvKAPnM
 ntfHQ9ZhPRVaBkHYXtyphYboVwrNYHb13okBhBP9l114fgbZSNIb2ZjetWP7Ei4ztFEL
 EkU4SGpQXn1BRD+aKfXs5ZAyXqShSsejgZN/3LznK750AE1grNlq/DoGnpN4IBtXfJn+
 TT2HpUlrJ9AkXNLJmY4sQjF70BnOHuau8yVhKSVEihHO2+waGt65NjrQt+t0wr2uU76/
 T2h8ZjOegMeC5UHHWIJkHz9cnesSoTT5RwXPWSSm6h3eNjl74IEumuOPdLlWg8kCKLca
 zCPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6fRMgLvasucmKDhYt+QZQCjagnxjwALNtw5248Ag281WIP0etT6OcXewbAvMF6SfiT4Lr3/5dK8OD@nongnu.org
X-Gm-Message-State: AOJu0YzjR34qpcGx3HAkjKqZxq+M5GK9Dgeh2CxW/blLEG3ExN3nzPDe
 DPJbNWcTC/NFvQ/bVD3MklcvZu2AYqW7qhcatBtiHi32hUUSzOywS/NaHY+2zJav221+dCiTRDc
 GUL6uc6JRfXZ/6MI4bWvCXw2z8YfFWD4iYNqN+YCSXr2uQZom/pdhauYjB24RjMM/xiJV
X-Gm-Gg: Acq92OFVwpPomBsg2GxLwGBqe4ACdqUynH0QLzPrrrK4GorzreYetZWtW6LhbqRWAzM
 Xr17oZQ+VD9EJpau1QtIYLmdCXcgYgss9Cc0yahzdZJDFV08ZgIA6Ht4yPSNRSC3xEYd6l1BbOV
 WI9wzE5FzBn1OtntuwnlT3rmdBET6oKHjXmfw4S2Vi5Z5zQQEa+kwBbz5Ek9h+QVZWcHwBdxBuK
 sXXGDZq5TLiRzCI3KsASzhaH/hI3Ts79E9/tYS/2pLjke9ZF4qk0LykccXSlOm5m+LPnz5LrH0c
 dPiQugmmUZ0Yf2IPklmmmOZEql/jaf4wXS8UErhVhX/gAP6M+uP+amuzIpNNiuBJHXB9FvnsGHI
 aw/Ry1Wzp3X+u1e+skQf0x6pgARK5i/M3LIF8LS6wjJ3kQ9ox8GfHg/Bcj9Nxq9XgXJd9BSlLdR
 Fae3S9Hk1giv8G7oh26qD9MptE
X-Received: by 2002:a05:7301:5f85:b0:304:4f23:68d3 with SMTP id
 5a478bee46e88-3074fbc6042mr4645393eec.18.1780587724590; 
 Thu, 04 Jun 2026 08:42:04 -0700 (PDT)
X-Received: by 2002:a05:7301:5f85:b0:304:4f23:68d3 with SMTP id
 5a478bee46e88-3074fbc6042mr4645370eec.18.1780587724061; 
 Thu, 04 Jun 2026 08:42:04 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df191d0sm7869720eec.21.2026.06.04.08.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 08:42:03 -0700 (PDT)
Message-ID: <03666c35-83f9-44ea-b31b-07bc75b0e5e7@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 08:42:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add a note on -shim to direct kernel boot docs
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20260604134422.359214-1-kraxel@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260604134422.359214-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NyPt-ARlGk8B6xabfwAmNQdimiTcPfAj
X-Proofpoint-ORIG-GUID: NyPt-ARlGk8B6xabfwAmNQdimiTcPfAj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE1MyBTYWx0ZWRfX3uvnTWpAGvDx
 xEh22Q1vlSs98eoV6ZftD3H8OOKURjTQgUhzBpvtut+iE6vq+VuCgXE9Sjo5Gq/HQ+oYoxmpZNt
 RFq56/S3chSsvAZFvFNIQvGdmfTHYvBtDb4tNvRWiDShAjEdEP55LbiqLVMUZuuOTKKf2sedLEK
 oE7d4eH3XGYlouxd8qHSO+D1koBeHmXZdfgDqyA/KLOaD6/018raTsqDIiDFl7zBeXQbO7ZVL5q
 6D+b9nThMHocpyDr8wL3WPP261CK6G0/p5PWzctQ+TyfIKWanRsEDevWV7kiH9dJdbPRVXEIc/v
 jmEW7KBWgIUEzPT67skhq/SCvbbEHnMvdN2D3+y2tCCXfx5wlzhT/Xsjw29aUi9xg8bRGhglkp/
 ebwOZQ0q/vbBtuW2AFLSPs1yFcbzjHL2saZ6Ov6KdvQ93S7AmP39b45VumlZ9WliVWHYzXcHgwK
 LG6f65Pu0/8pGjiJePA==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a219ccd cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=wLZQiVpf1cABdgcX:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=SEeG0rePwgFbj1vdvacA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040153
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Hi Gerd,

On 6/4/2026 6:44 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  docs/system/linuxboot.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
> index f7573ab80aa2..72af18ce1b5e 100644
> --- a/docs/system/linuxboot.rst
> +++ b/docs/system/linuxboot.rst
> @@ -17,6 +17,15 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
>  give the kernel command line arguments. The ``-initrd`` option can be
>  used to provide an INITRD image.
>  
> +The ``-shim`` option specifies the shim.efi binary.  This is needed
> +when using direct kernel boot with UEFI secure boot enabled.  The
> +verification chain used by linux distros requires shim.efi.  Typically
> +shim.efi is signed by micsosoft and verified by the firmware.  The
> +linux kernel is signed by the distro and is verified by shim.efi.  So
> +without shim.efi in the loop secure boot verification will not work.
> +Usually you can find shim.efi as ``EFI/BOOT/BOOT{X64,AA64}.EFI`` on
> +distro install media.
> +
>  If you do not need graphical output, you can disable it and redirect the
>  virtual serial port and the QEMU monitor to the console with the
>  ``-nographic`` option. The typical command line is:

Are the double space before sentences expected, or just a broken formatting?
Also, s/micsosoft/microsoft.

Regards,
Pierrick

