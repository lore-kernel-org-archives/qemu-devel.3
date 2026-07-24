Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE64C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnAfY-0003BU-BJ; Fri, 24 Jul 2026 03:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wnAfW-0003Ab-Iz
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 03:50:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wnAfU-0005w9-8Y
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 03:50:06 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lKeq2137669
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 07:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sUvwG5f/08HwAyDugOIALg/VzdAazTH3/WN9fh1NTqs=; b=Rq1apzbJMH9fWncd
 7T4prjqHkS6eIWiIHko3MdVONhYGfGRJEBhXSv1Pv7Cs//EBGPfT7rSRosuNObwQ
 yAqMZkIyEMFxc9ej17Zcq3IfAFi7p/SSLSe2IslvPH2d8rIf5o/n1/nYdjCBunK3
 9XmAS0tiokwq9fffTGniN91oV449wPRh0cup0WF1tW7gVOIB5WHRJIL6jvdWnZd5
 C8S02zAQ/e3c1QnebreAzpmRJGcrKEU1foo/2oz8E9VIQp83pBr/e31r+g3DmLm5
 QAmwk61s6Jzn0NC6sH+ZC2dCl+5x/+wsmsaLWmht7OndMlpOTLJAf3LEGMBwxwSz
 zFc9eg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa1arks-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 07:50:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174a236220so1987691cf.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784879400; x=1785484200; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sUvwG5f/08HwAyDugOIALg/VzdAazTH3/WN9fh1NTqs=;
 b=PpOpAw9OaKPyC9zr8yDqqtBTD41O72HDRoDSBaHm1V+SiKjAlpgCqPYbl5IxRCSQta
 AAW6FiNASy2vJxIIaes18EAs5pF8SYtd8KX9bCN109EXahrHEZ87T0p0R9fzQlrjtDmD
 OAWDYAtyXfrXql2k2V0UPnsKIh43qKhi82Z41tg3Akck5oQbC7DV5mjTRfVWGFw54Y/a
 VsY10f2WsxiQZ2qAeR3C3XvG2PGoIoTTlSMfbAazbonZn7e//ZQD9BLp/y73kpYCMFpW
 CTMG4eC5HnyZKeATkAPYKXKQPBmz8ScvknLtkULwO+m81qE9qyeTXuh6ZuVrN7hIbAAv
 Oj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784879400; x=1785484200;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sUvwG5f/08HwAyDugOIALg/VzdAazTH3/WN9fh1NTqs=;
 b=R3yD0a25zW2G/2r2uaLgxFz33I/goPK0kiCAOw//v/bD9Qf4wWBaa1tUIkDTlcjP5X
 aYKOamSHxesVer72M05DGx9TAKSltFpXZhUzZxAT82Zd+vaf0DbCXHuX11U+QNfHSIYX
 QZdzDNJvucYDTs4/Q7r7R8YWmkTs2ea8ncuknVswvhXDGkOo4DXPqTd1C4uEdOaZvzHU
 yYG+BnaXD2KTtFVS2t0Rkh3XGmU3MEcOsnmPyth/m46aEjPmL2TCbuaiO+x1Iu0Wav6d
 sysB8zyDoyLx9MO3qrrgqntQNVNP4uCnw7UkR2NWqT1vThHxfEX/ZIa8jpSKk7h1iUnr
 /xDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpM1Y/Vg01iNcLkA24k8VEldj07zwkt/byP14wGBJlkyIO3//nivcP2CL2ogg0NHhl8ZNWeR3i0yrlS@nongnu.org
X-Gm-Message-State: AOJu0YzAaRJXiYiF7kd3S0cCmGtMAll+beDJ+CoZRFQCaLumPfQ7oU0T
 iqeRJADahEn4UeOnr9avekJ92smjWbEne+tKNZ53ES5zOMqgb6PLyXgY4wRFPjoCJTnM9SSnfAO
 415CWMGbXvCKCOqOg2G2CcZ0PvXs+/4sBA1ListM5h3cfj5MMDTmDD5IgSg==
X-Gm-Gg: AR+sD10uRpnSJniqqYEnsqQCR1vjdm7Rjoc4X3orwCeWFGZymhqi03EIRri1oVHf5os
 KbScCXi+GqRSNziBHw42daRFkpwYrNLExSqdbQdQ4hVh5I4bjEj6uj3fBWkHJfyxRSbMN3EMbAG
 0ZPTrtd1Pe+pw2/7HAa+qwQYlDJCjcs0lQdXL+cejbKBbij2DAvhhVcbS7bpuQXwgwhxuWu/23T
 rJZG0l3RDiNCWIUAWXV3dNemogYYBeEyJ4QuYkjtsUinTEw+UR8gwyQK93hrZRDnj+W1ZiMa9GJ
 9oJvNU/HWAgTa2GVCnZhqFh8gFm6bC5SMBCsduEOfUtkwo7kCaiF2zf8mU6OPaedkfp1TPcpwx1
 i8f+9wMFMgixbfmjf4UDJqg==
X-Received: by 2002:ac8:5cd0:0:b0:51b:fcbc:84c6 with SMTP id
 d75a77b69052e-5283df9a8ffmr60657501cf.71.1784879400422; 
 Fri, 24 Jul 2026 00:50:00 -0700 (PDT)
X-Received: by 2002:ac8:5cd0:0:b0:51b:fcbc:84c6 with SMTP id
 d75a77b69052e-5283df9a8ffmr60657321cf.71.1784879399901; 
 Fri, 24 Jul 2026 00:49:59 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm20726379f8f.16.2026.07.24.00.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 00:49:59 -0700 (PDT)
Message-ID: <52b6e2f7-6b44-4d6c-b69d-090deaffda13@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 09:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hw/9pfs/xen: drain in-flight PDUs before xen-9p
 disconnect
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <cover.1784809978.git.qemu_oss@crudebyte.com>
 <82bc736158e827e05d4b55da27c39d42e2062e96.1784809978.git.qemu_oss@crudebyte.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <82bc736158e827e05d4b55da27c39d42e2062e96.1784809978.git.qemu_oss@crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9OPCPx27E_4ZswQC51mPSigvi58Yjgq3
X-Authority-Analysis: v=2.4 cv=L4wtheT8 c=1 sm=1 tr=0 ts=6a631929 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=K92WTf5yAAAA:8 a=uJdRzUSmhvFrqGOzBSkA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=X9ok8FpLfHEzVMsE4qxm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2OSBTYWx0ZWRfX3wRVElMpeZVH
 aGpaawMQOuxBUXWCf3eYWdclVsPqNEIWjUz2x8aKRGrsI2cCqW6BGOK1XnEK1LnEN7mpw83qa6e
 shH5UQWsPpFEiy7Ixi1zeeyjzhPIbIKxA9IsC6maO6kXqonQwmUCxHGxq9zHGt4UtbOfyii6WtQ
 /CghfVu7EXXj52AdoorvFxR9MzZYJI/rmb5TccqlHpd2z+SKzoqgD6NOY52Nbjb3u2FZo5CkEAR
 FkGhFlqYMbu/GytJd0U+/Jv3CQI3VfWC4D085xBOL51tRmvLEwiOdQ+cMfWkiHEWIa0yzFWeLwS
 Ow/QmBMMjbGh2f2FAHcyLjKiji4TNXzBK3ivvHgn9ePxXZY+oIaXgn/B0GxQ551nQRveIM8UaRo
 r7tPvFUvnH2/QIM/DoABLCIARWRqaJFQQnDar/XtiK6whtrqypzfBETqp2Ln+/YpEJQNv6VOXTk
 F62S2spsCqR41/7jwMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2OSBTYWx0ZWRfX9IenW6r2r3rw
 UYNvddWqKGd5nx1miGlL2MoDFMojRwQxJ16FQdWM359CAI5HoHWb+oJ1xAzcn3cGYShsi3kCuWF
 ElKVji+l8aFWus38A+/qrhpLuRwly4I=
X-Proofpoint-GUID: 9OPCPx27E_4ZswQC51mPSigvi58Yjgq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 23/7/26 14:43, Christian Schoenebeck wrote:
> The xen-9p disconnect path has two issues:
> 
> 1. It frees the Xen9pfsRing structures while in-flight PDUs may still
>     reference them via pdu->tag to index rings[]. This causes a UAF
>     in xen_9pfs_push_and_notify() when worker threads resume after
>     completing filesystem operations.
> 
> 2. It never calls v9fs_device_unrealize_common(), which means server
>     state (struct LocalData, mountfd, FIDs) is never cleaned up on
>     disconnect, causing a resource leak on every guest-initiated
>     disconnect.
> 
> Fix both by draining in-flight PDUs via v9fs_reset() before tearing
> down rings, and calling v9fs_device_unrealize_common() to clean up
> server state.
> 
> Additionally, explicit calls of xen_9pfs_disconnect() in the error
> paths of xen_9pfs_pdu_vmarshal() and xen_9pfs_pdu_vunmarshal() must
> be deferred (via aio_bh_schedule_oneshot()), because
> xen_9pfs_pdu_v(un)marshal() are running within a coroutine context
> which makes them unsafe [1] for calling v9fs_reset() directly, as
> the latter e.g. has a loop like:
> 
>      while (!QLIST_EMPTY(&s->active_list)) {
>          aio_poll(qemu_get_aio_context(), true);
>      }
> 
> which would a) never terminate (as the coroutine is on the
> active_list) and b) aio_poll() is marked as no_coroutine_fn.
> 
> [1] https://lore.kernel.org/qemu-devel/3351181.5fSG56mABF@weasel/
> 
> And finally, add an idempotent guard to xen_9pfs_disconnect()
> for the v9fs_reset(s) and v9fs_device_unrealize_common(s) calls
> specifically [2], just to be sure.
> 
> [2] https://lore.kernel.org/qemu-devel/alpine.DEB.2.22.394.2607221815520.5295@ubuntu-linux-20-04-desktop/
> 
> Fixes: b37eeb0201 ("xen/9pfs: introduce Xen 9pfs backend")
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
>   hw/9pfs/9p.c             |  1 +
>   hw/9pfs/xen-9p-backend.c | 17 +++++++++++++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 3119f01117..fc01791830 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -4530,6 +4530,7 @@ void v9fs_device_unrealize_common(V9fsState *s)
>       qp_table_destroy(&s->qpp_table);
>       qp_table_destroy(&s->qpf_table);
>       g_free(s->ctx.fs_root);
> +    s->transport = NULL;
>   }
>   
>   typedef struct VirtfsCoResetData {
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 24c90d97ec..a2f118d2ca 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -68,6 +68,11 @@ typedef struct Xen9pfsDev {
>   
>   static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev);
>   
> +static void xen_9pfs_disconnect_bh(void *opaque)
> +{
> +    xen_9pfs_disconnect(opaque);
> +}
> +
>   static void xen_9pfs_in_sg(Xen9pfsRing *ring,
>                              struct iovec *in_sg,
>                              int *num,
> @@ -150,7 +155,8 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
>                         "Failed to encode VirtFS reply type %d\n",
>                         pdu->id + 1);
>           xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                xen_9pfs_disconnect_bh, &xen_9pfs->xendev);
>       }
>       return ret;
>   }
> @@ -173,7 +179,8 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
>           xen_pv_printf(&xen_9pfs->xendev, 0,
>                         "Failed to decode VirtFS request type %d\n", pdu->id);
>           xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                xen_9pfs_disconnect_bh, &xen_9pfs->xendev);
>       }
>       return ret;
>   }
> @@ -368,10 +375,16 @@ static void xen_9pfs_evtchn_event(void *opaque)
>   static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
>   {
>       Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
> +    V9fsState *s = &xen_9pdev->state;
>       int i;
>   
>       trace_xen_9pfs_disconnect(xendev->name);
>   
> +    if (s->transport) {
> +        v9fs_reset(s);

Maybe v9fs_reset() is misnamed.

What about v9fs_cancel_in_flight()?

> +        v9fs_device_unrealize_common(s);

IIUC xen_9pfs_disconnect() is mixing XenDevOps::disconnect()
and XenDevOps::free()?

> +    }
> +
>       for (i = 0; i < xen_9pdev->num_rings; i++) {
>           if (xen_9pdev->rings[i].evtchndev != NULL) {
>               qemu_set_fd_handler(qemu_xen_evtchn_fd(xen_9pdev->rings[i].evtchndev),


