Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22369CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBCS-0003QR-MA; Mon, 15 Jun 2026 13:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBCP-0003MI-QG
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:34:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBCN-0001lg-W8
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:34:13 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFhVLl449178
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C7EPyWd1Vvbdkz+kA4trgixFzWXnfGtQ7nUX9uHA4Wo=; b=HdWvJwdMWwA+OXpe
 yuMiUK+NlwOgjfMNCah1RxRhAuUdenS3QCiQvFs9o3WR9Uzew1po450HCXrt4Bvu
 b/e/AT7r3cx/9lpAu3dAVdCc6EFa2v+5AHzHFxBMBlegLmeyzAbKu7QuMv7DQBWJ
 WNCAfprwogl9Ic0aJwX+XoVsV7DuNG9Bpi9aD38lv0E6naPVjFlKxRoTB2yOceFu
 2SBL06fKeXmQ7Tt/tWIyiONSHnYNVXd7sgVIuBDahg5lHlAhsk+vJOkD6WGjSvjr
 d8SgEkPROZadQCDkRxMd3W1NIoW/FnHL/hQL299n1jn8q9J3ccan6Q6rccGekAnd
 Ofw6hA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa71yw8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:34:10 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-307fe856724so2275955eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781544850; x=1782149650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C7EPyWd1Vvbdkz+kA4trgixFzWXnfGtQ7nUX9uHA4Wo=;
 b=M8QSdpwYwUBbXss8yWu6YogEmUMTU2l5ZIGgz/npvoXy36gLiEN2wpRUNXs29bZzey
 SJuRR6Fbf2Hp4I4dJroKUAm0GAVEx6Jm8INUGh2ikMOuxp1k8m6DdgS+EMVTnQ5FiPlX
 1G/gWBSGNLYOmxnELVqUwctN8bOcttmwBK6kAOFtbpUsQbnynHHZPKcS4VUXGAdf+QyZ
 KRrj515HKKgz5ayMrmv1fQVD5yiUjsFWAFwZ1YGTVoq1jPyUDNjJmeU2JMlRtg7pFdcc
 7fOyv/gkb6wbYbCAF/nW++CSP6qLQAFem82NDjRsIaquJlD12zH7RewPuNK0FS3ZpT/D
 Yv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781544850; x=1782149650;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C7EPyWd1Vvbdkz+kA4trgixFzWXnfGtQ7nUX9uHA4Wo=;
 b=qlDi87tuMA3Z3TEQiWhnOnDBERXFEk8X58c5vM9WZ0C7tmH06nF0+h+JrRS7KKr5HX
 90bdxakcyxKauhvgo79r3JPKgR1VpMmnMPbkED1K+ieDzIzaBVdH+l84h9rK5nXSv3gV
 8cIqJQqRwo0WzTxRz5w3v1QshXhXAYkaeCLE+aWySj4GaW9rTWGN45oeqcCLEwXDbiB3
 UQSjKukgKyOKLp/i4vfVW4YyiFDbnFhUWTa0z/lskF/10j3Sb+vIRluUq9Bo9MNV1bSj
 4tWc8MVyXONlgtpLPjJ94DOtwUG5h5WBd7FHHzzwkFxGtoF+fo7SiGEv86zwkxKZwnRJ
 0vmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Hr6MAWpDiKtOOk84/p2RT5s3L0ejiJmyG49W9Vtg0BtTanVzDXymP57ma1dEOJxmwZvwjeyeoXueA@nongnu.org
X-Gm-Message-State: AOJu0YxxzN+fwqO+ycSoe6B9Hg+DtqMSUxBdgmESei7Z2SVlQNvpOUuC
 syj6eQhsMhLb+oQhP2RK+6cjoiWLRo+hNvtqnshtxhQEigDxStBSo7FwjNkonVWrM+5mDKBSvKC
 fY7ELFZ42BjV6jO6coyXVpdS5PsN4zRJN2XO7Fl1rgr1KjDQazumBCGAJPg==
X-Gm-Gg: Acq92OH+cOJTkvVdwGu2D7fgyA8menQu3Jayf8Sk9flhiRMi+pwjiUdZaKuN/Nc8/0Y
 QOjzLhEKcqHJbphI+KNBE5Irk8rWwRqa7DzN2mEOVvd+ksFT6AA6/hpGwrkj93fWz+L0A6rBtH/
 MCEKPmGaggjiI5Z9n2QjzCC5+e6nghoQjlXvDfv2gQfgs+rvrmCIyyeLzDojtVOuPotJO8w461+
 FAef68YGCFlgdskzV0Qd7K3ggd7s10xo2+j9zSRKorjoJp2VYLPIZCLHRBTgS3fXZuvMkgtInZX
 QYwkiQynRfWChNvw7SWcpHxN3rQcKcAOjaVhhriYlOzfNb70O9jj+M35G5bgDysndin49WcFhkK
 N26wGmA9p8BhyzQ/7nkHooLcg5L4/uvXAQ1udWntA4GEC6CoFZl7nMfedMqCUbHBdRx+IfDakSB
 6ihLqxHqqRLAH32w==
X-Received: by 2002:a05:7300:4785:b0:304:eaa8:11ea with SMTP id
 5a478bee46e88-30ba5f6c864mr117673eec.34.1781544849618; 
 Mon, 15 Jun 2026 10:34:09 -0700 (PDT)
X-Received: by 2002:a05:7300:4785:b0:304:eaa8:11ea with SMTP id
 5a478bee46e88-30ba5f6c864mr117637eec.34.1781544849056; 
 Mon, 15 Jun 2026 10:34:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e92096esm15909610eec.15.2026.06.15.10.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 10:34:08 -0700 (PDT)
Message-ID: <63413d5b-e1c1-4fe0-9af4-2b5012ed185f@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 10:34:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] add a note on -shim to direct kernel boot docs
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20260612161707.158029-1-kraxel@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260612161707.158029-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0iLtqgrSWpCDWzri-eCB0JBhvDgW7IzR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX5NPkugQhSisV
 wo8MSbfw8VBrhkzqvIEjPshxiSymfbEutIa2bT7vGvggC1zESy+qpaPSm7iZ3LG5cJgIyfrHfZD
 +Yz8s2XY4n3pdRJ3dHyW3gO5AdL2zgA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX1AwBk0YkflG9
 GOBfRwY1LMsrciih2CpgOP1bqMlmClG1tcXaZnuxh0R2YzqKvhgSFwirb1OGni33tUjTwFHNNjj
 D9++xgHgGOxPRaicpIuYVDfBI2MYBTQsUjDc+2Pb8J2eU46JzGBw4VVV4YtSjc41jK57f+3sdZI
 NDZF9c+gaWCTD+Bboiv5UskdkNRrQ8ccgvTAABdCvjxblP5xULfNQa52jJYIIdmUdLnNP7xslTN
 0n01+76GsGEVzcaYTxIHcahFU3GBnZfkZpRToq4CKvgx/yL12Fd+jz0jcRHiZQIMy6x/QhCivom
 68stJuJ9SsZYfLUkZz+Qt+cBLlmW3uMfc5QDFRS89GcZPMoRiAZCP9WpF59OUOse4gfRoSd+qzz
 Nx2Dh1do3lvX366DdrayTMQtCHjRzwJVAB7HbS++JbIqsc6LfUzhmziceLL2ESkGM6cUq8EJNs7
 bzv7QPvDqwNVkz+Y+AA==
X-Proofpoint-GUID: 0iLtqgrSWpCDWzri-eCB0JBhvDgW7IzR
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a303792 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=wLZQiVpf1cABdgcX:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=MTJmOtltlxYebVe3IGYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150186
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 6/12/2026 9:17 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  docs/system/linuxboot.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
> index f7573ab80a..c787481ccc 100644
> --- a/docs/system/linuxboot.rst
> +++ b/docs/system/linuxboot.rst
> @@ -17,6 +17,23 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
>  give the kernel command line arguments. The ``-initrd`` option can be
>  used to provide an INITRD image.
>  
> +The ``-shim`` option specifies the ``shim.efi`` binary.  This is needed
> +when you are booting UEFI firmware and using the ``-kernel`` option to
> +tell UEFI to boot a specific kernel image, and the UEFI firmware you
> +are booting has UEFI secure boot enabled.
> +
> +When this option is specified, the guest UEFI firmware will first
> +load, verify and run the shim binary, which is typically signed by
> +Microsoft so the firmware accepts it.  The shim binary in turn will
> +load and verify the Linux kernel.  The kernel is typically signed by
> +the distro and the certificates needed to verify them are compiled
> +into the shim binary, so shim + kernel must come from the same Linux
> +distribution.
> +
> +Usually you can find shim.efi as ``EFI/BOOT/BOOT{X64,AA64}.EFI`` on
> +distro install media.  You might find a second shim copy in the
> +``EFI/$distro/`` directory.
> +
>  If you do not need graphical output, you can disable it and redirect the
>  virtual serial port and the QEMU monitor to the console with the
>  ``-nographic`` option. The typical command line is:

Good for me, I'll wait for additional reviews to pull it directly.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

