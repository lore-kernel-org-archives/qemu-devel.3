Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42D9C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wttU1-0003JW-A4; Tue, 11 Aug 2026 16:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wttTz-0003Ii-EZ; Tue, 11 Aug 2026 16:53:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wttTx-0000Bs-P8; Tue, 11 Aug 2026 16:53:59 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BJVaBk1240871; Tue, 11 Aug 2026 20:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QARGMk
 GiShj/CVJmdul2GVOQ6StppG7LPk1HIp2P75o=; b=mZPyrVha9+4cPNuSKxDtTG
 UYZTwC3mKte8xOS1QQVSYW3lWbFQO9OFnJHTy3u541x73+HXTedX+t7iofoRs0Oi
 nxdfSYDY1QDTXbkuYSwxT61kOadeHJZcoKqrUMR4vHUEo/3y7DfCWRc9RE1WBimO
 Mlp1a4ij8EQzUqLAGBJargkKZLAoplNsIXNbud74P/D/oYXkYJUOKglMV/WAe4Q5
 t7mnZTfEW4UhRmjgW+iyJB3fh+tWgM3IaR3PHTURfjaDBnpT6yzkN7sMi1OPg7+o
 Ljj0w15oxqMhdtbO9QfsUR+iN+3oXgO1k6ohU0fkaZ0p3ka3ikkQMsX3Wh3IXlRw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2xg80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 20:53:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BKfOD2025616;
 Tue, 11 Aug 2026 20:53:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h2tw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 20:53:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BKrh4k2622460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 20:53:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D51C5805A;
 Tue, 11 Aug 2026 20:53:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89EA358056;
 Tue, 11 Aug 2026 20:53:41 +0000 (GMT)
Received: from [9.61.90.231] (unknown [9.61.90.231])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 20:53:41 +0000 (GMT)
Message-ID: <eff52141-990b-4315-be9d-fe5b127f49c2@linux.ibm.com>
Date: Tue, 11 Aug 2026 16:53:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] hw/s390x/virtio-ccw: Always inject NMI to first CPU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
 <20260811154930.13915-3-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 xsFNBF7EiEwBEADGG0EtNKnjp+kQfEVqlqxXoBHjnaQptFpMgxNlz2GtqOujY6nzEWnybIXY
 63XUTmMS/tWUf2DTbNCNoWwumGM/I2Gj1uGyMnc4Q477BQlL/e2/9MRaut11rwHsi4zmWylc
 jO0eFTSLFA8yFBj9osT3uZzk5TwWkD8sf+rD916fFVk0G39uYEd5sjEzjeOf9/dwXyZpjJY6
 api1pUHEw7weRvOnllJAfIKFz+KoR6d7ezvMF9zOYHF73FGeSVIYoIEUhA5Cdg60rSlTtHb2
 cftex3/cEapvY5bK3CKJ33BVVK10Bht9XfVaA/AOcg/3o5ZbhSIwz4xScGsEVf/Yr368YMdr
 3VkCZrmN2ppmVRz/RvAmCyItnmzoVDlSREA6Faw6S0x8Oi7lN0cKh2hy9VPcVupraXJZrdAh
 GtdU+jrJvSbpdsrX8F7K3RwynbiqGrqC0izGla04hhtei/uwthatglukuxep4PknDGbzijg8
 Ef7A8t3qEVklUDrsnNPN5HbR9QQdeF0HuWsDTfILbZv1MICfOK3BCDeT5mJWaJCoQ2rbuljM
 e1hFSt+mr7GV4h6NcBE+uGIqDSzQORtyTo0uBV4et3cSE84JxOfXBMrj0TlL1855JaIoPWEN
 uhDRB/dHW8+Fumq2du5hLcaXPka+MO26cNVKVLF0/JjwMTZ9bQARAQABzSJFcmljIEZhcm1h
 biA8ZmFybWFuQGxpbnV4LmlibS5jb20+wsGuBBMBCABYAhsDBwsJCAcDAgEGFQgCCQoLBBYC
 AwECHgECF4AdGGh0dHBzOi8va2V5c2VydmVyLnVidW50dS5jb20WIQTSxgUEyej1aM/lh7U4
 J7IScb+VYgUCYel8TgAKCRA4J7IScb+VYsHAD/9BSQj7HeJf90PttOmVh35Bb4QyHLZ4g+9x
 waM59JCKGbiURuNRIGnoRarYXHk6vfy19v8v56Dy1IOlKWaRnizp5Mw9zXBBTCs4fgNbOzY/
 SggFY2UzcziXDG29X9zznq5LgY1Jf/cwm1O+rn89GKCZWZhLEB2wKzBj7hum7NBdW+lxfVwp
 2qONGDerttWDwAHxJ995k9aDJahq9kIKEMEZbrTQ8JI8KZGoox6+HA04EhoNzxvbV0J+/gLJ
 2DkvxN5/xmcD3z+s8B5ev3NarOF17AIA9oCdfu8CPAupcNqJW86m19P5q6AyRB2ZLyAIAAhr
 HCXrnlh/8HJW1yCOVXxprFdpg1SX1fuArjbFAh53vVVDfkZlwHeTeE7+3y1rtDLfy830pqdD
 ymv94yey2y1+iZBdbaW0fSC/JkjkOCy8oZawkH3geM4MXV4ze4gbBH6BhxW/0gbEYjnLm3FA
 53JcXwhHQFPWIYEYYPvATJi0JUiMY1Znkm3QBWDOCXSrG0tHpAclBa9L40zLRwA1h9YOMFEs
 qvKijUdvcDf4sTdJ+A6YL66grzul5vNt06NlqsI8HUDHE6vghqyWxupCav2+9b1BuLie++er
 b8OCo5n3TUHsVMjYJEePU1EkcCa84dCm+CXqPthgRv0sbe4UQEd/qUoVMdWj7Q7FL96mBn0G
 zM7BTQRexIhMARAAp+k1sC4y7Wtwjqtfu9wIihvY/Vot0v/sKg8CRGRIIRGLiCeA9o+2ZlxC
 jYztT3Leri5Vo5z09OmRMvoFLJjcHMCG5sYeZwOWNAbeuAxGkIMDSB4pLl3t2c+1PQuMBCd7
 +mRZFaMEJfT3nhdUKxy2rp1+YucnA67xGXUJCiD5l9UmhPqa7SAYlpMAqDz7cmBo25c/UNm1
 Tpwjrh70jq/4guV5gnprawH8nkRjdKH1JvKWvkuaB7FNZ9IuSHlWclcQX4IQMsaxsU2emAbP
 VYv7l4YNlKfdlJd8tuEodjuMLOBnr7e9H0hVNUWGFN9bkBNRu3zi/jvhyu15Iu4euR/WdVNu
 2K2iYxIfiGMnv0F/a6R1bm10lCJrjyf23J8DYIeH4YmHvOOqYFkq3DWOctlXbb3+aABqjYt3
 mkiOLXeplqbo/m3rWcGNd8Q/d1aVA0wm5+Nt3RdSuXG2FHOFdVUQKPLpf1NUH/LInBhS/9Ys
 ajm6tWXKv7hxwWmyz0u/th6gUra3KpARB1ypebWHULLNzKGwVS81XNs76QhXwX04cyiwLqKb
 WqLqJKThz+rLa09Ap+eO/UzPfFXvWYWfTeFRIQ/tKF332ZzRR8Xrh/fk//YXyRfpoE/7i5uz
 ve0HZWp5jXg9Yb+S6g0+XUKznnN9B8WLLCcuRIuSa722070v7KsAEQEAAcLBdgQYAQgAIAIb
 DBYhBNLGBQTJ6PVoz+WHtTgnshJxv5ViBQJh6XwwAAoJEDgnshJxv5Vib28P/1BYT5gvjuEB
 A80AXo/IqycicXxDJtrfmyw4COP7bi7AuiDcKyA1wRzC51paKwPFB8Unk2GvG4DV6aDmGTJY
 +GeCYgthQ+znW461S8B6GqDCAQt2VDNNFVU+gTuh7vYQOgt/OjtiiAvMIJBVRbXoNSRokKOF
 tpTiXf3ZOsAkot5ZmxE0TV94v18sp/bC84YvFyaxpw5bilT7bmpcq8B8/3yb0kmy6gXLcQAp
 OnomV3sQBmm050amiO3tvxMNv8J71AvNdTG/rojTDKUl2Nw4f+aw4nVw874m2XpEe9JGRw54
 5d2dN8k3GpzcTBe9fCQPOFHOGkQ1CgptDkQuQVD3DIeNzQjXf6xehEymIKnLOkukT2smV0zh
 fj08z7eiv+dsmnBsbhdM6DKU8qIgkTu77TfHUKjjOY/Mj0YHPuH/J4b1AZFxBhGP0BTKiB2W
 CR6/49XVKvY1jHxgadSSNCD+f7tEqUNBlVl+P0emMJaYpK1+gy88ma4g3nvyOVe/VzDPjGDC
 4HX/6RAR4Dbzry6/epWTTji+7ApzePzmJzPcuzD31ICsgT2dJ6ydxyxxXikBFJqx6BPOF+u+
 1BtKcTz1ek3I2sWvBM1V5CKaFw7iNXxS6HgS2scuAT2awKq+BQlt778/GfBWpXonfqixMvit
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260811154930.13915-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b8bd9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=j8j1x0kM0YOnaRB183sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Mw3NB359GchMMJl3BGeGzBVWCvMB6N_I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE3MyBTYWx0ZWRfX19sSDPLTJTp/
 O7C4c4l9r9D72IXnR3GoFFMBJe+WNRaTxwwV792DK0UcwfbfVZbJrxOSb3at00Hu0/NR/8Kxyle
 l/V7WQsdKsNqLGl4m8F0P7UvcqB2/O4p/C1oZOPqPL7ZDqv/Tz1GhmJ9I8ffJ9n51l/4F4rCEMb
 48A35MYRIEFO13hhjqMlkcuDIh2wPs0m973THdPVrMZ5rvuieV50TD0wkMaU4gP1rnIZt6YdtXB
 E7j8ziHxqw1dGSiuQYMvkVnGAPWx/dgqfwGW7GJ61prr+maavKkoM0ZJ2Zw6eOiwUxDINmCeLAA
 zgLQYho25M24xgJcjhkEFQUPI1Xrr8Ht6sF2rEZNNVrJeXLwe7yY07nJ3jrJsXn1XrN7W/yLjDP
 5VxORSBpKuW/yVZLWIr8X8jyjRCksvSub+pP2ph9I8i99G1dCKwzj8O2I2Iuyv9XY06ReUUcXmX
 4T4QIHMYVgQ70eCTHMg==
X-Proofpoint-ORIG-GUID: Mw3NB359GchMMJl3BGeGzBVWCvMB6N_I
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE3MyBTYWx0ZWRfX3TNM6zUZcas0
 wrUL/taPwLMIpuC3BkoMXtZwlY5xqb0ZIR/DUVwgH98rLperoI75u/zev+kH0HBHBkhV3tY7mzc
 xQPaWqvzjO1cAVFCNNgZnSgZ3rthTu0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110173
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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



On 8/11/26 11:49 AM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> We can trigger NMI from HMP or QMP.
> 
> QEMU maps the NMI to the s390x per-CPU 'RESTART' interrupt.
> Linux guests usually setup this interrupt to trigger kdump
> or crash. Such crashdump can be triggered in QEMU by HMP
> "nmi" or QMP "inject-nmi" commands.
> 
> Using QMP, since we can not select a particular CPU, the first
> CPU is used (CPU#0). See the documentation from commit 795dc6e4
> ("watchdog: Add new Virtual Watchdog action INJECT-NMI"):
> 
>    @inject-nmi: a non-maskable interrupt is injected into the
>                 first VCPU (all VCPUS on x86) (since 2.4)
> 
> While we can select a particular CPU on HMP, the guest behavior
> is expected to be the same if using CPU #N or CPU #0. Since
> always using CPU#0 simplifies API maintainance, update s390_nmi()

nit: maintenance

> to inject NMI to the first CPU.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   qapi/machine.json          | 7 ++++---
>   qapi/run-state.json        | 6 ++++--
>   hw/s390x/s390-virtio-ccw.c | 4 +---
>   hmp-commands.hx            | 5 +++--
>   4 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 9b2248038fc..2d63c1bac3b 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -432,9 +432,10 @@
>   ##
>   # @inject-nmi:
>   #
> -# Injects a Non-Maskable Interrupt into the default CPU (x86/s390) or
> -# all CPUs (ppc64).  The command fails when the guest doesn't support
> -# injecting.
> +# Injects a Non-Maskable Interrupt (machine specific: for example on
> +# s390x CCW only the first vCPU receives the NMI, but on x86 machines
> +# all vCPUs receive it).  The command fails when the guest doesn't
> +# support injecting.
>   #
>   # Since: 0.14
>   #
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index a5771ad4681..e4fdead1e0b 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -317,8 +317,10 @@
>   #
>   # @none: nothing is done
>   #
> -# @inject-nmi: a non-maskable interrupt is injected into the first
> -#     VCPU (all VCPUS on x86) (since 2.4)
> +# @inject-nmi: a non-maskable interrupt is injected (machine
> +#     specific: for example on s390x CCW only the first vCPU
> +#     receives the NMI, but on x86 machines all vCPUs receive
> +#     it).  (since 2.4)
>   #
>   # Since: 2.1
>   ##
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 25a9fa49554..4f7861dbbb7 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -727,9 +727,7 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
>   
>   static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
>   {
> -    CPUState *cs = qemu_get_cpu(cpu_index);
> -
> -    s390_cpu_restart(S390_CPU(cs));
> +    s390_cpu_restart(S390_CPU(first_cpu));
>   }
>   
>   static inline bool machine_get_aes_key_wrap(Object *obj, Error **errp)
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 7ae2468a3d9..a1b77ae4044 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -865,12 +865,13 @@ ERST
>           .name       = "nmi",
>           .args_type  = "",
>           .params     = "",
> -        .help       = "inject an NMI",
> +        .help       = "Inject an NMI, in a machine-specific way",
>           .cmd        = hmp_nmi,
>       },
>   SRST
>   ``nmi`` *cpu*
> -  Inject an NMI on the default CPU (x86/s390) or all CPUs (ppc64).
> +  Inject an NMI, in a machine-specific way.
> +  Not all machines implement NMI handling.
>   ERST
>   
>       {


