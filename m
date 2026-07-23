Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC89C531CA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmtsy-0007hN-PP; Thu, 23 Jul 2026 09:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmtsw-0007gH-N8
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 09:54:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmtst-00034s-8j
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 09:54:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCvkJc4050184
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 13:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A/G6b07n1aG5WqVtoXCMHc0SDwBDMWryXmtRsXKttD4=; b=oDH5ZHuSBbcYEgSh
 79+xldoXMdgQbuLTChTBVMsdq6iGFYmsCMxdCvRZURbcWgW5fYE0qX9zWiXB3+tw
 ClH4aPbfoVWETjRUxbnmhmK6SFxD/jAPI64X7xZZllFqspDMXxo4CvyugtaV11uM
 HqlWhT1+qtSjpB1SJt5w0Ed95PInxFdDCxPDEigAUpfwAFtuTnhs+ODVyDPD7Y2v
 dWA5rH2utox0xX9xvpVVXuPFDTPWekWNX9l4IrgR/5SUROUL1Dwk0zWPk3g7Umll
 S0+5Cg+ONcAfYzHRjnoyU6qgEk3iS6VF2VLlg5LiX8Qf8uC8a/JYtOI++3qeRO1z
 SMXjhQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28vme4b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 13:54:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bf321d786so8404501cf.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784814885; x=1785419685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A/G6b07n1aG5WqVtoXCMHc0SDwBDMWryXmtRsXKttD4=;
 b=OhTy5fR5xb43Nyya4bIJyOUT8i8SeMU8RvZKTL/SZavqejhTrvydr7ppfQ+acM7XRD
 nyu1vr/Au6cbbQjDG2RE2rK751j7lvGMc9Uc4SIuApRziV+IJ8rNFc8NdH0Nwwmqg8ZZ
 6s6IcZA/DMNcLoysOywNfiN8pMlqJZcd05Kjnm+o/I4QnkDY/3weWffS9tgh72CPHmEi
 Y6um6xgbjW0km0LLgNbW8ya7U8DcOi5ZbNn8JASFP3i+aZAYBWmLpHxZKnvnkFfKV+aW
 3FGhrsJIPn2ZnbYzop8Ku1IKYgWjs206F27HjZ4SGe6hAa+fpRZhvTcpwolgSgPXU9Ze
 JSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784814885; x=1785419685;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A/G6b07n1aG5WqVtoXCMHc0SDwBDMWryXmtRsXKttD4=;
 b=c4eDacHB0YWfxucfHeW6XN9QXkMJWK2VdRAJPpUycCajn83Huf5dRdQZqHH3XP0Z8/
 5RnFLadhAjGsz1UhnXLx5MCyty8p7kwZw8ndsBymmNh6YqWRTjG53hy/dtMStE9PXj8l
 3M5hfVw5/a0fJ/c5A507XpEoD07Ah0M4st97n1c2zK7EwCYdOwSn2/5kuFrMLv7a1R09
 6WmqbCJqwQKoECPQmaHrGhW2mwUnHAhJejTOAgMpR5Qg+MNhUpdIXU9SXKY8xZYPVMEQ
 qOmddbiE7HPd0X5uarFRp3QBBtCVY8h4Ldm/woo1OlAs/5dsKpmI4BRRm4h+twgTi130
 WXtg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXBb5ShnCERrb3BI8/9LVklQVj5iRSximnXz9yRoqLzU/WV2BX7OMcRQ7kR5YcI3pdb7NgkS7s0AK+@nongnu.org
X-Gm-Message-State: AOJu0YzVUSdkvnOjxpCU4S0HSUjXw6v3cJtMGn5p9zkLHczMbx+rLzH4
 thHX3DXw0N4kkHazF3xaAD0Dpuqqg4MTasZkn/ol5gnciUKWLV1TFdTd0uDOTuBHFBXyJHunXcY
 hH7V1LhViTv/IMBPHUvTGTD9Q1rNYsYr6Bg2co8qDGeFZnLzLULfov8N4PQ==
X-Gm-Gg: AR+sD104We2wG72sbe26cTbv+HyDlohcLAzFtC3pwVB2QSOimitxi8pL6GKVNsWJHqV
 qbkgXDPWtUoHAXX/z2+GOOoMvNcowV3w/AODJaYVKz9C1LSK66jQb+/iFH/ss+ItYJj0s/Vy865
 a9V2ZLDWqRENngEFyPdE33Y2KwS/nr6Nx1oVjnVm8s1lXLE5Z2Shw59j3yAi4zHWeubPh/fv7rB
 R07zv6TkTAF3PsCT3iTDVIoO5dlSoTK+Hus4q9xumxlp6/sZ0b6TvzKGs0DdJUueXAK8w8jEQmj
 dVHKHPX9RFDbX7xfNMiz8s+IZNCPovo8WbaucB7bTN3lgYjv1/wXNmWyt4Irn1sPWwVcq7GxHNE
 nhSnJC7DUMYweWA5ewIb2b7cehhuRNNEGEqtR4pcH5F1mrqimM3k=
X-Received: by 2002:ac8:58cd:0:b0:51c:2022:cf0c with SMTP id
 d75a77b69052e-5283decc83cmr27652711cf.57.1784814884612; 
 Thu, 23 Jul 2026 06:54:44 -0700 (PDT)
X-Received: by 2002:ac8:58cd:0:b0:51c:2022:cf0c with SMTP id
 d75a77b69052e-5283decc83cmr27652351cf.57.1784814884038; 
 Thu, 23 Jul 2026 06:54:44 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bfed7sm242692595e9.11.2026.07.23.06.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 06:54:43 -0700 (PDT)
Message-ID: <28b3741f-3cab-4e7c-b830-01fad0d80d35@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 15:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display/vmware_vga: Don't allow guest to trigger
 long running loop in host
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
References: <20260723124432.353969-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723124432.353969-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNyBTYWx0ZWRfX4Ou5GZHdoNzl
 5vFXgQP7G7+fgfUmodqz5bbMXeBmbJ16eY4qt7gGb8awif4mY/JgLNHrYKqe6GpWmyPenyG/2Hz
 ktCSIz+1YDKkGLv6cKbz9hr3GPOAoH4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNyBTYWx0ZWRfX6iS6uBCwXwrz
 NzsepwlPgxc9SinOeftlVCoTAw1Kn6b0eMz2+rb0tP4DXq/AP1kpCFkWMMj+oh1BMHuXrRrihAe
 iU0XvwKPzczKrdqL/tdi5C4LQ/2jcICaZ6McxP86oVsuZzE2GIKCg3sDxGHA5yEgpZBvZrEXmHm
 JzlG4qqi2S8dEJ7pU2k5pXCKDTGJV7czT6VcreUI1Uu73km+7e1xS5ZWiEeCbsfjUMoZQUzF4/o
 tcz8Fv19ASpkQhAvgaaAif7mcgj6UzqZ9YMNmJCP+qozJg2b80W1UsTb8MUuaFLm60Y4dfEPv1c
 IRONQNr8pkJpXOKd8Jh2M+E1GwX2KpOO+ieoug8PJFTlgOEdXEnI0PxpcTBDZtml+nVRiBk0KAi
 W/PXeShKmxVsX1SgFnH1/t0UgQStiFYYKqNgOITifqiP/geLa7+WaDgQ2IMgcEu5iVqy5QoFfdC
 qMpnAGMsSMSF1pVFjCA==
X-Proofpoint-ORIG-GUID: sBOaiO9r1318zZSxQRHqs1vppxGbsFy4
X-Proofpoint-GUID: sBOaiO9r1318zZSxQRHqs1vppxGbsFy4
X-Authority-Analysis: v=2.4 cv=D4V37PRj c=1 sm=1 tr=0 ts=6a621d25 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=J_-Nd1mkAAAA:8 a=EUspDBNiAAAA:8
 a=AbWGNAM0AYlVCVsMptEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230137
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/7/26 14:44, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The code in the SVGA_CMD_DEFINE_ALPHA_CURSOR handler in vmsvga_fifo_run()
> basically does:
> 
>              x = vmsvga_fifo_read(s);
>              y = vmsvga_fifo_read(s);
>              args = x * y;
>              goto badcmd;
>              ...
> badcmd:
>              len -= args;
>              if (len < 0) {
>                  goto rewind;
>              }
>              while (args--) {
>                  vmsvga_fifo_read(s);
>              }
> 
> Thus by supplying huge values for x and y that overflow the result of
> the multiplication, the guest can trigger a long-running loop here
> that burns the host's CPU cycles.
> 
> Add some sanity checks so that this cannot happen anymore.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3782
> Reported-by: Feifan Qian <bea1e@proton.me>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4026
> Reported-by: Tristan Madani <tristan@talencesecurity.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4076
> Reported-by: Sunday Jiang
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Use SVGA_MAX_WIDTH and SVGA_MAX_HEIGHT instead of an arbitrary value
> 
>   hw/display/vmware_vga.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
> index f6f9edfd1d9..567806f0e47 100644
> --- a/hw/display/vmware_vga.c
> +++ b/hw/display/vmware_vga.c
> @@ -737,6 +737,10 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
>               vmsvga_fifo_read(s);
>               x = vmsvga_fifo_read(s);
>               y = vmsvga_fifo_read(s);
> +            if (x < 0 || x >= SVGA_MAX_WIDTH ||
> +                y < 0 || y >= SVGA_MAX_HEIGHT) {

vmsvga_fifo_read() returns unsigned... otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +                goto rewind;
> +            }
>               args = x * y;
>               goto badcmd;
>           case SVGA_CMD_RECT_ROP_FILL:
> @@ -776,7 +780,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
>               if (len < 0) {
>                   goto rewind;
>               }
> -            while (args--) {
> +            while (args-- > 0) {
>                   vmsvga_fifo_read(s);
>               }
>               printf("%s: Unknown command 0x%02x in SVGA command FIFO\n",


