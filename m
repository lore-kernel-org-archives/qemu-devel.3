Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B213DC5B574
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wthsw-0001Hp-Ma; Tue, 11 Aug 2026 04:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wthsb-0001H0-7e
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:30:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wthsZ-0008FP-6W
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:30:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67B7MJhJ2937881
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +uaMvkNNWmz+Eoz4VzD2r2BpszwfS133jwDrWa8Sofs=; b=jGui6/KVe06QVLtO
 Ape8w0oywwduyvy/S//k5faYF9q/1v1s2ZiwO52luj23tnVkQVESdlIS/HCNwX7z
 WzbBkagXF+5mpfSX8nUgHb1g5/odlBPQ4JB0yKZGRCFKHWURceyJ/xN5mAvnyETJ
 qPbGD81G/rt9PF6lTSSWyYgqfDeOViWVkvqSP2r3IAQv8yUeONZkTY3iJwsELFg5
 cZlpNR1xBTEQQlsGoremFuSlLTvChTf6vGKGV4UV2qws8Ire0EnqWHAy9Ib/IF0E
 jgKNg8lj9t1gsUORB8DR8WFSZwa1JyO7eJ73bGtKE1/u3BVNbJ3bSxTqkK8kMSf7
 0e9TIQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjv346x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:30:31 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8eac2620cb0so3024226d6.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786437031; x=1787041831; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+uaMvkNNWmz+Eoz4VzD2r2BpszwfS133jwDrWa8Sofs=;
 b=KnKHoylP7Oma3A242zKQgvhgPHpUOFft2ShFIsFryci0eZJHk667+cxj5FghDHqKOY
 CY3JFTo0LzvjllX9LoKBAcCWLcyd1vS5UmQbE6o9GkaxI0XjLskLHhGJfBuqsn8sfUWx
 WwgwUYp3HzcSc5zThELJIQ9TpZ6MaRwAXj7hzS2MD3r5YeI3ZbFb++VM561nafW61YBj
 x9ne70+vg99vv+dl4ozxB8le/o8JeAxi2XzwXaw7fCB9fJpbokfVKqzd+ahqKapIJlHJ
 7css5CKNIPpb60Vbo+925srKLzJU9mti63/BTVGicrprN+HNCdR+o6dx9o7E0eG/Kfus
 OZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786437031; x=1787041831;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+uaMvkNNWmz+Eoz4VzD2r2BpszwfS133jwDrWa8Sofs=;
 b=Zcs+snRhew/Hd7xA7CnsXWwPmaVWmhyvfEjjPdhmO1TxU7AH2dN+v4v5D9L07ucqDK
 LV9uft8wuwIZ33m2AlJyYhxCUMdDC+tOIVRybrpYIt3FIDKdbarzT6xv4couSKe3ekuO
 wWqb5Qxc7LPLQtXIINwA5/e3TRAOgBQaH1e/7GI74NyIXUcBJUt5oiqRsQH/iF7J9wzy
 CePirHRSZ40V/eKT3vRlZyNYE+NbhcOCR0QYobXB5wbRKwkjGapfnFeyUt7n0PpFpdU2
 lRH5K7NRtJSOd3YOe+/SOf14JKuRkMtudvVkzS9KKu/MlJHOfq2+iY/RdZLz92y7gKak
 6RnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoF/v2y1PIJkfd5ChJw+C65N9rEttwJ0P3/HcSjO/hZs1J6s4PEsTj2yQ5dsgPHv+adK/7DXIdRBBWI@nongnu.org
X-Gm-Message-State: AOJu0YyhSRu8Cg1olSS9z0Zc743S01qAn4axerJkiyy2mbPJJbgJMta5
 pI09qY13q9K1BlpXJwX+Sm7clv4B1e3SJIz2Xk9Fc6uELzw24IKmNdcWhS/EzBcbw3C+vAUWD8g
 LyP6sssh5H9hJ8eRY+F9JllWZuIqieKs1isntWLe/2HjzO9T3aSIo2avHqA==
X-Gm-Gg: AR+sD10INTtI1WzIjnn5HqnWhZBaseSTk9+t3vy5I97rPxGJE8qMSZvOFS6XlMiP3hl
 1fEYegB83aPZpgzC3zBhFMA+Zxn+exBAs8D31hlUsPtEwmP65Kndrtny3rmSf9vEguUll6vMgX2
 keffOBRO6sy5XPfQvtZVBuk1ZoL0IEoUgQbzwVTEfj8Y3yKpZOzjQNIV9E9E2OIoWoduWWPHU+G
 hzSXyr8/DST0epX65O4CCAHFC2TVZY3Vmo8C0fmCJUWwJinSzoi3dBaf5RN0mopwULMkhCkzG2C
 1W2PRP6KrloMUuMuXTgitQMzMvvJAotUNKWvIo8p7+xkCrwlam5DZkoOHSMpwcsLMpwQKbd1kbt
 yG0D2jCLLFOatR6Id6PLxHZ3n/538FklsLCE=
X-Received: by 2002:a05:622a:991:b0:51c:92a0:b2ca with SMTP id
 d75a77b69052e-52d58624d77mr12506171cf.34.1786437031222; 
 Tue, 11 Aug 2026 01:30:31 -0700 (PDT)
X-Received: by 2002:a05:622a:991:b0:51c:92a0:b2ca with SMTP id
 d75a77b69052e-52d58624d77mr12505881cf.34.1786437030807; 
 Tue, 11 Aug 2026 01:30:30 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977bab479sm23011655e9.0.2026.08.11.01.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 01:30:29 -0700 (PDT)
Message-ID: <33a61f97-d058-466c-9793-98e2618790ba@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 10:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/char/pl011: support backend hotswap
Content-Language: en-US
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
References: <20260811081401.51771-1-alexander@mihalicyn.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811081401.51771-1-alexander@mihalicyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA2OSBTYWx0ZWRfX97IYrdn0EhKt
 LT7P5AladAelRqy2cIwc+pKQN6/X8NmA1qS4HGYFyIugv2Pa/jRL50XXyHvBo31E128DgYaQSFn
 ToqxQAxUz0i6LeCeBNMRGaSnrD71gO7eVaj0PvTH5hucFg9iEQPiK5JfjC93Z7Rj4BNEx+kY2om
 wgWb7ayuo58z554njqJPH0DmNxMbZ/PLK+cYBiQP+g861HRBOiNCK1ZARR0Uo9063+Ou7muC7xf
 DNpyo0Wf6gY1K4r/H33uRkkLxyvFaks85VvfxMK1BLO1Vgx7iA+4vwNa7pRnG8k806XqI2e7KCc
 yWpB2HRinchDta4Noy28P75/jg0w+qAe9+YbZMDBq7RChazRGcxMhQPOrJkLgILQAZkHt2yfR5E
 S6l2tnQZz3REsotPkSzrCk7avw1C+POQp7fdubo7B3kjINnUOygbHRlRBLYuEBxbOqbUc2Y83/H
 XbblVav3+jFwUreKBNw==
X-Proofpoint-ORIG-GUID: 8ffUJ3lJCnEWjDyhrs9wZnyUY7WAW1k9
X-Authority-Analysis: v=2.4 cv=KLtqylFo c=1 sm=1 tr=0 ts=6a7adda7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=7QyriEpAAAAA:8 a=NEAV23lmAAAA:8 a=45JYyly_AAAA:8 a=KKAkSRfTAAAA:8
 a=s4FlSMO-zaOHw5fvBAEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=pwq3ROT0nMnQUTg0Q3_8:22 a=Whl4MVJGvnkbPDY6VtYj:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 8ffUJ3lJCnEWjDyhrs9wZnyUY7WAW1k9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA2OSBTYWx0ZWRfX4nV/wUjThYGe
 9p55pYPfQP6JsbsbzcyIPWP5v/V1eY+J+8pNXukB6b/cOePE0p8tO8uGffAyUCYHwPWZdfKUyKs
 gemRtT+Hil6Qx3Q/54GMz1m/pZyi/BQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110069
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

Hi Alexander,

On 11/8/26 10:14, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> 
> Currently, when Incus issues "chardev-change" QMP command to change
> chardev backend from ringbuf to socket it receives an error (with aarch64 VM):
> "Chardev user does not support chardev hotswap" [1], [2]
> 
> Let's fix this by properly implementing BackendChangeHandler for pl011.
> 
> Please, note that we have to "replay" CHR_IOCTL_SERIAL_SET_BREAK, because
> if BRK bit was set before backend change (i.e. (s->lcr & LCR_BRK) is true),
> then after change we need to send break to a new backend too.
> 
> Link: https://discuss.linuxcontainers.org/t/unable-to-connect-to-vm-console-on-arm-architecture/23096/3 [1]
> Link: https://github.com/lxc/distrobuilder/issues/892 [2]
> Reported-by: Stéphane Graber <stgraber@stgraber.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> ---
> v2:
> 	- fixed a typo in commit author name
> 	  [ I did `git format-patch` and copied this patch from my Raspberry PI
> 	    dev/test machine and it turns out that I have a stupid typo in my
> 	    `git config get user.name` on that machine. ]
> 	- added RWB tag from Alex Bennée
> 	- adjusted a commit message
> ---
>   hw/char/pl011.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index cb12c3e224f..3622248ec0c 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -660,12 +660,26 @@ static void pl011_init(Object *obj)
>       s->id = pl011_id_arm;
>   }
>   
> +static int pl011_be_change(void *opaque)
> +{
> +    PL011State *s = opaque;
> +    int break_enable = s->lcr & LCR_BRK;
> +
> +    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
> +                             pl011_event, pl011_be_change, s, NULL, true);
> +
> +    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
> +                      &break_enable);

Could we factor the common code used in pl011_write() in a common
helper?

> +
> +    return 0;
> +}
> +
>   static void pl011_realize(DeviceState *dev, Error **errp)
>   {
>       PL011State *s = PL011(dev);
>   
>       qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
> -                             pl011_event, NULL, s, NULL, true);
> +                             pl011_event, pl011_be_change, s, NULL, true);
>   }
>   
>   static void pl011_reset(DeviceState *dev)


